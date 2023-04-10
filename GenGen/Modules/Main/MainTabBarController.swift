//
//  MainTabBarController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 25/03/2023.
//

import UIKit

// MARK: - TabBar Items
public enum TabBarItemType: Int, Equatable {
    case generator
    case library
    
    var viewController: UIViewController {
        var viewController: UIViewController

        switch self {
        case .generator:
            viewController = GenerateViewController()
        case .library:
            let libraryViewModel = LibraryViewModel()
            viewController = LibraryViewController()
        }
        viewController.tabBarItem = self.tabBarItem
        return viewController
    }
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .generator:    return UITabBarItem(title: Texts.generatorTabBarTitle,
                                                image: AppTheme.TabBar.Image.generator,
                                                selectedImage: AppTheme.TabBar.Image.generator)
        case .library:      return UITabBarItem(title: Texts.libraryTabBarTitle,
                                                image: AppTheme.TabBar.Image.library,
                                                selectedImage: AppTheme.TabBar.Image.library)
        }
    }
}

// MARK: - MainTabbarController
final class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    static let tabBarController = MainTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        setColors()
    }
    
    // MARK: - Creation
    static func create(selectedTab: TabBarItemType = .generator) -> MainTabBarController {
        
        let generatorVC = TabBarItemType.generator.viewController
        let libraryVC = TabBarItemType.library.viewController
        
        let viewControllerList: [UIViewController] = [generatorVC, libraryVC]
        
        setViewControllers(viewControllerList)
        
        tabBarController.selectedIndex = TabBarItemType.generator.rawValue
        
        return tabBarController
    }
    
    /** Embed each ViewController in tabbarController in a UINavigationController */
    private static func setViewControllers(_ viewControllerList: [UIViewController]) {
        tabBarController.viewControllers = viewControllerList.map {
            let navigationController = UINavigationController(rootViewController: $0)
            navigationController.navigationBar.backgroundColor = AppTheme.TabBar.Color.background
            return navigationController
        }
    }
    
    // MARK: - Style
    private func setColors() {
        tabBar.tintColor = AppTheme.TabBar.Color.selectedItem
        tabBar.unselectedItemTintColor = AppTheme.TabBar.Color.unselectedItem
        tabBar.backgroundColor = AppTheme.TabBar.Color.background
    }
}
