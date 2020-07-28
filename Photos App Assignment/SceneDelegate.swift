//
//  SceneDelegate.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit


// MARK: - Scene Delegate


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
