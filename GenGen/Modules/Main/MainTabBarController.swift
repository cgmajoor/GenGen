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

        setViewControllers(tabBarController, viewControllerList)
        tabBarController.selectedIndex = TabBarItemType.generator.rawValue

        return tabBarController
    }

    private static func setViewControllers(_ tabBarController: MainTabBarController, _ viewControllerList: [UIViewController]) {
        tabBarController.viewControllers = viewControllerList.map {
            let navigationController = UINavigationController(rootViewController: $0)
            navigationController.navigationBar.backgroundColor = AppTheme.TabBar.backgroundColor
            return navigationController
        }
    }

    private func setColors() {
        tabBar.tintColor = AppTheme.TabBar.selectedItemColor
        tabBar.unselectedItemTintColor = AppTheme.TabBar.unselectedItemColor
        tabBar.backgroundColor = AppTheme.TabBar.backgroundColor
    }
}
