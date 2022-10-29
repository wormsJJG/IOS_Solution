//
//  SceneDelegate.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: scene)
        let cordinator = Cordinator(window: self.window!)
        cordinator.start()
    }
}
