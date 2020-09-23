//
//  QuestionDetailViewControler.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//


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
