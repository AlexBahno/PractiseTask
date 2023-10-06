//
//  Post.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

// MARK: - PostsModel
struct PostsModel: Codable {
    let posts: [Post]?
}

// MARK: - Post
struct Post: Codable {
    let postID, timeshamp: Int?
    let title, previewText: String?
    let likesCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
