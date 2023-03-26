//
//  MainTabBarController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 25/03/2023.
//

import UIKit

public enum TabBarItemType: Int, Equatable {
    case generator
    case library

    var viewController: UIViewController {
        switch self {
        case .generator:    return GenerateViewController()
        case .library:      return LibraryViewController()
        }
    }

    var tabBarItem: UITabBarItem {
        switch self {
        case .generator:    return UITabBarItem(title: "Generator", image: UIImage(named: "magicWand"), selectedImage: UIImage(named: "magicWand"))
        case .library:      return UITabBarItem(title: "Library", image: UIImage(named: "book"), selectedImage: UIImage(named: "book"))
        }
    }
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        setColors()
    }

    static func create(selectedTab: TabBarItemType = .generator) -> MainTabBarController {
        let tabBarController = MainTabBarController()

        let generatorVC = TabBarItemType.generator.viewController
        generatorVC.tabBarItem = TabBarItemType.generator.tabBarItem

        let libraryVC = TabBarItemType.library.viewController
        libraryVC.tabBarItem = TabBarItemType.library.tabBarItem

        let viewControllerList: [UIViewController] = [generatorVC, libraryVC]

        tabBarController.viewControllers = viewControllerList.map {
            return UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = TabBarItemType.generator.rawValue

        return tabBarController
    }

    private func setColors() {
        tabBar.tintColor = UIColor(named: "GGDarkGray")
        tabBar.unselectedItemTintColor = UIColor(named: "GGGray")
    }
}
