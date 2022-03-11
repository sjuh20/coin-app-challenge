//
//  File.swift
//  
//
//  Created by Gustavo Jesus Gomes on 09/03/22.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
  var navigationController: UINavigationController {get set}
  init(navigationController: UINavigationController)
}
