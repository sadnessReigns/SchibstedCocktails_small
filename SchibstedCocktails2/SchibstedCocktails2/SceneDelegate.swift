//
//  SceneDelegate.swift
//  SchibstedCocktails2
//
//  Created by Uladzislau Makei on 25.05.25.
//

import UIKit
import NetworkingLibrary

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var service: CocktailService?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let service = CocktailService()
        self.service = service
        let cocktailListViewModel = CocktailListViewModel(service: service)
        let cocktailListViewController = CocktailListViewController(viewModel: cocktailListViewModel)
        window?.rootViewController = UINavigationController(rootViewController: cocktailListViewController)
        window?.makeKeyAndVisible()
    }
}
