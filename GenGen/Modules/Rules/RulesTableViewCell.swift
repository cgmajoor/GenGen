//
//  RulesTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

class RulesTableViewCell: UITableViewCell {

    // MARK: - UI
    private var label: GGLabel?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label = nil
    }

    func configure(ruleName: String) {
        label?.removeFromSuperview()
        label = GGLabel(textColor: .black, font: AppTheme.Main.FontStyle.label, fullText: ruleName)
        guard let label = self.label else {
            return
        }
        contentView.embed(view: label)
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
