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
    
    var requestItems: Items? = nil

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
                    self.tableView.reloadData()
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestItems?.questions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        return cell
    }
}
