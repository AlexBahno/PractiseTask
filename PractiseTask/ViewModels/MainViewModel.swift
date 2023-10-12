//
//  MainViewModel.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

protocol MainViewModelProtocol {
    func numberOfRows() -> Int
    func getData()
    func sortPosts(sortOption: SortOptions)
    func mapCellData()
}

class MainViewModel: MainViewModelProtocol {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[PostCellViewModel]> = Observable(nil)
    var dataSource: PreviewPostsModel?
    
    func numberOfRows() -> Int {
        return self.dataSource?.posts?.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        APIManager.shared.getPosts { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isLoading.value = false
            switch result {
            case .success(let data):
                strongSelf.dataSource = data
                strongSelf.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func sortPosts(sortOption: SortOptions) {
        switch sortOption {
        case .default:
            self.mapCellData()
        case .date:
            self.cellDataSource.value?.sort(by: { $0.postDate < $1.postDate })
        case .likes:
            self.cellDataSource.value?.sort(by: { $0.likesCount > $1.likesCount })
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.posts?.compactMap({PostCellViewModel(post: $0)})
    }
}
