//
//  PostCellViewModel.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

class PostCellViewModel {
    var title: String
    var previewText: String
    var likesCount: Int
    var postDate: Int
    var isExpand: Bool = false
    
    init(post: Post) {
        title = post.title ?? ""
        previewText = post.previewText ?? ""
        likesCount = post.likesCount ?? 0
        postDate = PostCellViewModel.daysBetween(
            start: Date(timeIntervalSince1970: TimeInterval(post.timeshamp ?? 0))
        )
    }
    
    static func daysBetween(start: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: Date.now).day!
    }
}
