//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 08/03/22.
//

import Foundation

import SwiftUI

public class MainCoordinator: Coordinator {
    // MARK: - Variables
    public var childCoordinators = [Coordinator]()
    public var navigationController: UINavigationController?
    
    // MARK: - Constants
    public required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        start()
    }
    
    // MARK: - Methods
    public func start() {
        //        wantsToNavigateToHomeCoordinator()
    }
    
    //    public func wantsToNavigateToHomeCoordinator() {
    //        let homeCoordinator = HomePageCoordinator(navigationController: navigationController)
    //        homeCoordinator.coordinatorDelegate = self
    //        homeCoordinator.start()
    //    }
    
}
