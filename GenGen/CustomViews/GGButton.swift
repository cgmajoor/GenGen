//
//  GGButton.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit

class GGButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = AppTheme.Main.Color.buttonTitle
        titleLabel?.font = AppTheme.Main.FontStyle.buttonTitle
        translatesAutoresizingMaskIntoConstraints = false
    }

}
