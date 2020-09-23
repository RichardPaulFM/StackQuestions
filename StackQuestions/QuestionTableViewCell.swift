//
//  QuestionTableViewCell.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//

import Foundation
import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isAnsweredImage: UIImageView!
    @IBOutlet weak var numberOfAnswersLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var userNameImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    public var question: Question? {
        didSet {
            self.isAnsweredImage.tintColor = question!.isAnswered ? UIColor.green : UIColor.darkGray
            self.numberOfAnswersLabel.text = String(question!.answerCount)
            self.titleLabel.text = question!.title
            self.userNameLabel.text = question!.owner.displayName
            
            self.tagsLabel.text = question!.tags.joined(separator: ", ")
            
            if let imagePath = question!.owner.profileImage, let imageURL = URL(string: imagePath) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            self.userNameImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
}
