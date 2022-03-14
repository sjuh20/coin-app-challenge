//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation
import CommonsProtocols
import UIKit
import CoinModularCoins
import CoinModularFavorites

public final class HomeCoordinator : Coordinator {
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        
        let homeBar = UITabBarController()
        let coinsViewController = UINavigationController(rootViewController: CoinsViewController())
        let favoritesViewController = UINavigationController(rootViewController: FavoritesViewController())
        homeBar.tabBar.backgroundColor = .darkGray
        homeBar.setViewControllers([coinsViewController, favoritesViewController], animated: false)
        
        guard let items = homeBar.tabBar.items else {
            return
        }
        
        let images = ["dollarsign.square", "star.fill"]
        let titles = ["Moedas", "Favoritas"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
            items[x].title = titles[x]
        }

        homeBar.modalPresentationStyle = .fullScreen

        self.navigationController.pushViewController(homeBar, animated: false)
    }
}


