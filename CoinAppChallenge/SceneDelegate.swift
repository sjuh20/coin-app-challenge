//
//  SceneDelegate.swift
//  CoinAppChallenge
//
//  Created by Ana Brito Souza on 07/03/22.
//

import UIKit
import Coordinator

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        
        let window = UIWindow(windowScene: windowScene)
        //            window.rootViewController = ViewController()
        
        
        let tabBar = UITabBarController()
        let firstView = UINavigationController(rootViewController: FirstViewController())
        let secondView = UINavigationController(rootViewController: SecondViewController())
        tabBar.tabBar.backgroundColor = .darkGray
        
        tabBar.setViewControllers([firstView, secondView], animated: false)
        
        guard let items = tabBar.tabBar.items else {
            return
        }
        
        let images = ["dollarsign.square", "star.fill"]
        let titles = ["Moedas", "Favoritas"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
            items[x].title = titles[x]
        }
        
        tabBar.modalPresentationStyle = .fullScreen
        window.rootViewController = tabBar
        
        //            window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

