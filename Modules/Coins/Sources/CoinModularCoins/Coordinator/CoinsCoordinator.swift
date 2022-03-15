//
//  File.swift
//  
//
//  Created by Ana Brito Souza on 09/03/22.
//

import Foundation
import CommonsProtocols
import UIKit
import CoinModularCoinDetail


class ViewModel<T> {
    let model: T
    
    init(model: T) {
        self.model = model
    }
}



public final class CoinsCoordinator : Coordinator {
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let detalhes = UINavigationController(rootViewController:CoinsViewController())
        self.navigationController.pushViewController(detalhes, animated: false)
    }
    
    public func navigateToDetails(coinId: String) {
        self.navigationController.pushViewController(CoinDetailViewController(coinId: coinId), animated: false)
    }
    
}

