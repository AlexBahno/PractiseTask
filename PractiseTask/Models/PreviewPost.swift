//
//  Post.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

// MARK: - PreviewPostsModel
struct PreviewPostsModel: Codable {
    let posts: [PreviewPost]?
}

// MARK: - PreviewPost
struct PreviewPost: Codable {
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
