//
//  ViewController.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let requestURL = URL(string: "https://api.stackexchange.com/2.2/questions?tab=week&order=desc&sort=votes&site=stackoverflow")
    let session = URLSession.shared
    
    var requestItems: Items? = nil {
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
        let task = session.dataTask(with: url) { (dataResponse, urlResponse, errorResponse) in
            if let error = errorResponse, dataResponse == nil {
                print("There was an error for the request: \(url). Error: \(error)")
                return
            }
            guard let response = urlResponse as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Wrong MIME type!")
                return
            }
            DispatchQueue.main.async {
                do {
                    self.requestItems = try JSONDecoder().decode(Items.self, from: dataResponse!)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
}
// MARK: - TableView delegate and datasource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestItems?.questions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionTableViewCell
        if let question = requestItems?.questions[indexPath.row] {
            cell.question = question
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let questionDetailViewController = storyboard?.instantiateViewController(identifier: "questionDetailViewController") as? QuestionDetailViewController else { return }
        guard let question = requestItems?.questions[indexPath.row] else { return }
        navigationController?.present(questionDetailViewController, animated: true, completion: {
            questionDetailViewController.question = question
        })
        
    }
}
