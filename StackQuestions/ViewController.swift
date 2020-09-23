//
//  ViewController.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let requestURL = URL(string: "https://api.stackexchange.com/2.2/questions?pagesize=100&site=stackoverflow")
    var requestHandler: RequestHandler?
    
    var questions: [Question] = [] {
        didSet {
            self.tableView!.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = requestURL else {
            print("Failed to obtain URL")
            return
        }
        requestHandler = RequestHandler(withURL: url)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        refreshData(refreshControl: refreshControl)
    }
    
    @objc func refreshData(refreshControl: UIRefreshControl) {
        requestHandler?.startTask(withCompletition: { (data) in
            do {
                let items = try JSONDecoder().decode(Items.self, from: data)
                self.questions = self.filterQuestions(items.questions)
                refreshControl.endRefreshing()
            } catch {
                
            }
        })
    }
    
    func filterQuestions(_ questions: [Question]) -> [Question] {
        let filteredQuestions = questions.filter { (question) -> Bool in
            question.isAnswered && question.answerCount > 1
        }
        return filteredQuestions
    }
    
}
// MARK: - TableView delegate and datasource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionTableViewCell
        
        cell.question = questions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let questionDetailViewController = storyboard?.instantiateViewController(identifier: "questionDetailViewController") as? QuestionDetailViewController else { return }
        let question = questions[indexPath.row]
        navigationController?.present(questionDetailViewController, animated: true, completion: {
            questionDetailViewController.question = question
        })
        
    }
}
