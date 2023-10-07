//
//  NetworkConstants.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
        
    }
    
    public var serverAdress: String {
        "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    }
    
    public var postDetailsServerAddress: String {
        "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/"
    }
}
