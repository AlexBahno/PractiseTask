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
    
    static func getPosts(
        completionHandler: @escaping (_ result: Result<PostsModel, Error>) -> Void
    ) {
        guard let url = URL(string: NetworkConstants.shared.serverAdress) else {
            completionHandler(.failure(NetworkError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, response, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PostsModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(NetworkError.cannotParseData))
            }
        }
        .resume()
    }
}
