//
//  OnboardingCollectionViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    private var imageView = UIImageView()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(image: UIImage) {
        imageView.removeFromSuperview()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true

        contentView.embed(view: imageView)
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = AppTheme.Main.Color.tableViewBackground
        contentView.backgroundColor = .clear
    }
}

