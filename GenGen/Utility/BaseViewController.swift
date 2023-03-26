//
//  BaseViewController.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 26/03/2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setColors()
    }
    
    private func setColors() {
        self.view.backgroundColor = AppTheme.Main.Color.background
    }

}
