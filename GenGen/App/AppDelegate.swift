//
//  AppDelegate.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 14/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppConfig.configure(application)

        //print("LOG: \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")

        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = MainTabBarController.create()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

