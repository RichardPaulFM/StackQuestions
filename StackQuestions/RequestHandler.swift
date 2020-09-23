//
//  RequestHandler.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//
import UIKit

class RequestHandler {
    let session = URLSession.shared
    let url: URL
    var task: URLSessionTask?
    public var taskState: URLSessionTask.State? {
        get {
            return task?.state
        }
    }
    
    init(withURL url: URL) {
        self.url = url
    }
    
    func startTask(withCompletition completition: @escaping (_ data: Data) -> Void ){
        task = session.dataTask(with: url) { [self] (dataResponse, urlResponse, errorResponse) in
            if let error = errorResponse, dataResponse == nil {
                print("There was an error for the request: \(url). Error: \(error)")
                return
            }
            guard let response = urlResponse as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Wrong MIME type!")
                return
            }
            DispatchQueue.main.async {
                completition(dataResponse!)
            }
        }
        task?.resume()
    }
    
    func stopTask(){
        guard let dataTask = task else { return }
        dataTask.cancel()
    }
}
