//
//  Post.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 07.10.2023.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    let post: Post?
}

// MARK: - Post
struct Post: Codable {
    let postID, timeshamp: Int?
    let title, text: String?
    let postImage: String?
    let likesCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
