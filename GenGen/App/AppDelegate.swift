//
//  AppDelegate.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 14/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCoreDataTransformers()

        AppConfig.configure(application)

        AppRouter.shared.startApp()

        return true
    }

    func setupCoreDataTransformers() {
        ValueTransformer.setValueTransformer(UUIDArrayTransformer(), forName: NSValueTransformerName("UUIDArrayTransformer"))
    }
}

