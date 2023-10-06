//
//  Observable.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T?) -> Void
    private var listener: Listener?
    
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        listener?(value)
        self.listener = listener
    }
}
