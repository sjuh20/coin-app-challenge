//
//  SceneDelegate.swift
//  CoinModular
//
//  Created by Ana Brito Souza on 09/03/22.
//

import UIKit
import CommonsProtocols
import CoinModularCoordinator

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        self.window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        
        self.window?.rootViewController = navigationController
        _ = MainCoordinator(navigationController: navigationController)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}
