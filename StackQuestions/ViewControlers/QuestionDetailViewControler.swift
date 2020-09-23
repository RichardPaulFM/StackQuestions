//
//  QuestionDetailViewControler.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//  Simple ViewController; It receives an object of the type 'Question' and loads its link into the WebView. This controller could instead load all the information of the question (Answer, comments, upvotes, score, etc.) using native elements, but to keep the implementation simple and agile it was decided to leave it to the browser.


import UIKit
import WebKit
class QuestionDetailViewController: UIViewController {
    
    @IBOutlet weak var webBrowser: WKWebView!
    public var question: Question? {
        didSet {
            guard let browserLink = question?.link, let browserURL = URL(string: browserLink)  else {
                return
            }
            let urlRequest = URLRequest(url: browserURL)
            self.webBrowser.load(urlRequest)
        }
    }
}
