//
//  Post.swift
//  Blog
//
//  Created by 김동헌 on 2022/07/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var postContent: [PostContent]
    var date: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case postContent
        case date
    }
}

// Post Content Model
struct PostContent: Identifiable, Codable {
    var id = UUID().uuidString
    var value: String
    var type: PostType
    
    enum CodingKeys: String, CodingKey {
        // Since firestore keyname is key
        case type = "key"
        case value
    }
}

// Content Type
// Eg Header, Paragraph
enum PostType: String, CaseIterable, Codable {
    case Header = "Header"
    case SubHeading = "SubHeading"
    case Paragraph = "Paragraph"
    case Image = "Image"
}
