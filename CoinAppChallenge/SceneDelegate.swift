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
<<<<<<< HEAD
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
        let window = UIWindow(windowScene: windowScene)
        let vc:ViewController = ViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationBar.barStyle = .black
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
=======
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        self.window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        
        self.window?.rootViewController = navigationController
        _ = MainCoordinator(navigationController: navigationController)
>>>>>>> 9f470fe7eb730c0b8bd5f6e5536d40b20e621d81
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
