//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation

class ViewModel<T> {
    let model: T
    
    init(model: T) {
        self.model = model
    }
}
