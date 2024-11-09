//
//  GGLabel.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit

class GGLabel: UILabel {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor = .clear,
         textColor: UIColor = AppTheme.Main.Color.labelTitle,
         font: UIFont = AppTheme.Main.FontStyle.generationLabel,
         textAlignment: NSTextAlignment = .center,
         fullText: String = "") {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.text = fullText
        configure()
    }
    
    private func configure() {
        numberOfLines = 0
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setText(fullText: String) {
        self.text = fullText
    }
}
