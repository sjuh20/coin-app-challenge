//
//  File.swift
//  
//
//  Created by Gustavo Jesus Gomes on 09/03/22.
//

import Foundation
import UIKit
import CommonsProtocols
import CoinModularHome

public class MainCoordinator: Coordinator {
    // MARK: - Variables
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController

    // MARK: - Constants
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        start()
    }

    // MARK: - Methods
    public func start() {
        wantsToNavigateToHomeCoordinator()
    }

    public func wantsToNavigateToHomeCoordinator() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
 
}
