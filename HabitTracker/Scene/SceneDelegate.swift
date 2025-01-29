//
//  SceneDelegate.swift
//  HabitTracker
//
//  Created by Тимофей Олегович on 22.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let mainController = MainViewController()
        let mainNavitaionController = UINavigationController(rootViewController: mainController)
        window.rootViewController = mainNavitaionController
        window.makeKeyAndVisible()
        self.window = window
    }
}

