//
//  PostCellViewModel.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation
import UIKit

class PostCellViewModel {
    
    var id: Int
    var title: String
    var previewText: String
    var likesCount: Int
    var postDate: Int
    var isExpand: Bool = false
    
    init(post: PreviewPost) {
        id = post.postID ?? 0
        title = post.title ?? ""
        previewText = post.previewText ?? ""
        likesCount = post.likesCount ?? 0
        postDate = .daysBetween(
            start: Date(timeIntervalSince1970: TimeInterval(post.timeshamp ?? 0))
        )
    }
}
