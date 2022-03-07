//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 07/03/22.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    func start()
}

extension Coordinator {
    func getStoryboard(nameStoryboard: String) -> UIStoryboard {
        let pathBundle = Constants.bundleAppealCopy
        
        return UIStoryboard(name: nameStoryboard, bundle: pathBundle)
    }
}
