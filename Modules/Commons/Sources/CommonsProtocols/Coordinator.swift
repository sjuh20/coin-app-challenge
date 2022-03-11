//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
  var navigationController: UINavigationController {get set}
  init(navigationController: UINavigationController)
}
