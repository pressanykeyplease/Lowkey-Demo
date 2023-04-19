//
//  SceneDelegate.swift
//  Lowkey-Demo
//
//  Created by Eduard on 19.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = ChatModuleBuilder.build()
        let nvc = UINavigationController(rootViewController: vc)
        window.rootViewController = nvc
        self.window = window
        window.makeKeyAndVisible()
    }
}
