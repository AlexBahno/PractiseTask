//
//  APIManger.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case cannotParseData
}

class APIManager {
    
    public static var shared = APIManager()
    
    private init() {
        
    }
    
    func getPosts(
        completionHandler: @escaping (_ result: Result<PreviewPostsModel, Error>) -> Void
    ) {
        guard let url = URL(string: NetworkConstants.shared.serverAdress) else {
            completionHandler(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, response, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PreviewPostsModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(NetworkError.cannotParseData))
            }
        }
        .resume()
    }
    
    func getPostBy(id: Int,
                   completionHandler: @escaping (_ result: Result<PostModel, Error>) -> Void
    ) {
        let urlString = "\(NetworkConstants.shared.postDetailsServerAddress)\(id).json"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, response, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PostModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(NetworkError.cannotParseData))
            }
        }
        .resume()
    }
}
