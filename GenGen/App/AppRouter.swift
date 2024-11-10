//
//  AppRouter.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    var window: UIWindow?

    func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        showLoadingScreen()
        window?.makeKeyAndVisible()
    }

    private func showLoadingScreen() {
        let loadingVC = LoadingViewController(router: self)
        window?.rootViewController = loadingVC
    }

    func showMainTabBar() {
        let tabBarController = MainTabBarController.create()
        window?.rootViewController = tabBarController
    }
}
