//
//  MainTabBarController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 25/03/2023.
//

import UIKit

public enum TabBarItemType: Int, Equatable {
    case generator

    var viewController: UIViewController {
        return ViewController()
    }

    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: "Generator", image: UIImage(named: "generateButton"), selectedImage: UIImage(named: "generateButton"))
    }
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func create(selectedTab: TabBarItemType = .generator) -> MainTabBarController {
        let tabBarController = MainTabBarController()

        let generatorVC = TabBarItemType.generator.viewController
        generatorVC.tabBarItem = TabBarItemType.generator.tabBarItem

        let viewControllerList: [UIViewController] = [generatorVC]

        tabBarController.viewControllers = viewControllerList.map {
            return UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = TabBarItemType.generator.rawValue

        return tabBarController
    }
}
