//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation
import UIKit
import CommonsProtocols
import CoinModularCoinDetail

public final class FavoritesCoordinator : Coordinator {
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let favorites = UINavigationController(rootViewController: FavoritesViewController())
        self.navigationController.pushViewController(favorites, animated: false)
    }
    
    public func navigateToDetails(coinId: String) {
        self.navigationController.pushViewController(CoinDetailViewController(coinId: coinId), animated: false)
    } 
}
