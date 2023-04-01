//
//  GGLabel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit

class GGLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, textColor: UIColor, fullText: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.text = fullText
        configure()
    }

    private func configure() {
        numberOfLines = 0
        textAlignment = .center
        font = AppTheme.Main.FontStyle.buttonTitle
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
