//
//  MainViewModel.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[PostCellViewModel]> = Observable(nil)
    var dataSource: PostsModel?
    
    func numberOfRows() -> Int {
        return self.dataSource?.posts?.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APIManager.getPosts { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading.value = false
            switch result {
            case .success(let data):
                print("Found \(data.posts?.count ?? 0) posts")
                strongSelf.dataSource = data
                strongSelf.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.posts?.compactMap({PostCellViewModel(post: $0)})
    }
}
