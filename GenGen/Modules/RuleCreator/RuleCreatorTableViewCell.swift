//
//  RuleCreatorTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 11/04/2023.
//

import UIKit

class RuleCreatorTableViewCell: UITableViewCell {

    // MARK: - UI
    private var label = GGLabel(
        backgroundColor: AppTheme.RuleCreator.Color.actionBackground,
        textColor: AppTheme.RuleCreator.Color.actionForeground,
        font: AppTheme.Main.FontStyle.label,
        fullText: ""
    )

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.setText(fullText: "")
    }

    func configure(bookName: String) {
        label.setText(fullText: bookName)
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppTheme.Padding.vertical),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppTheme.Padding.vertical),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppTheme.Padding.horizontal),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppTheme.Padding.horizontal),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: label.font.lineHeight + 10.0)
        ])
    }
}
