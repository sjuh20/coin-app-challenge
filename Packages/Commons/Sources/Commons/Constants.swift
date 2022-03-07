//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 07/03/22.
//

import Foundation

struct Constants {
    static let bundleAppealCopy: Bundle = .current
}

extension Bundle {
    static var current: Bundle {
        class DummyClass {
            init() {
                
            }
        }
        return Bundle(for: DummyClass.self)
    }
}
