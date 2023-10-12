//
//  PostDetailsViewModel.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 07.10.2023.
//

import Foundation

protocol PostDetailsViewModelProtocol {
    
    func getPost()
}

class PostDetailsViewModel: PostDetailsViewModelProtocol {
    
    var isLoading: Observable<Bool> = Observable(false)
    var post: Observable<Post> = Observable(nil)
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func getPost() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APIManager.shared.getPostBy(id: id) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading.value = false
            switch result {
            case .success(let data):
                strongSelf.post.value = data.post
            case .failure(let error):
                print(error)
            }
        }
    }
}
