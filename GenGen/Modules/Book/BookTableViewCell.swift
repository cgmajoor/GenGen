//
//  BookTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 04/04/2023.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: - UI
    private var label = GGLabel(textColor: AppTheme.Main.Color.labelTitle, font: AppTheme.Main.FontStyle.label, fullText: "")

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.setText(fullText: "")
    }

    func configure(with wordTitle: String) {
        label.removeFromSuperview()
        
        label.setText(fullText: wordTitle)

        contentView.embed(view: label)
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
