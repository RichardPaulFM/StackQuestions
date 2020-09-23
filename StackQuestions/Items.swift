//
//  Items.swift
//  StackQuestions
//
//  Created by Richard Paul Flores on 9/23/20.
//  The construction of the model classes was done with the help of https://app.quicktype.io/ . Some of the models were renamed to have suitable name given the nature of the project, aditionally, some of the properties of the json were ignored.

import Foundation

// MARK: - Items
struct Items: Codable {
    let questions: [Question]
    let hasMore: Bool
    let quotaMax, quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case questions = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Question
struct Question: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount: Int
    let acceptedAnswerID: Int?
    let answerCount, score, creationDate: Int
    let questionID: Int
    let link: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case acceptedAnswerID = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case creationDate = "creation_date"
        case questionID = "question_id"
        case link, title
    }
}

// MARK: - Owner
struct Owner: Codable {
    let userID: Int
    let profileImage: String?
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
}
