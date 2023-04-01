//
//  WordCategoryTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit

class WordCategoryTableViewCell: UITableViewCell {

    // MARK: - UI
    private var label: GGLabel?

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

    func configure(wordCategory: WordCategory) {
        label?.removeFromSuperview()
        label = GGLabel(textColor: AppTheme.Main.Color.labelTitle, font: AppTheme.Main.FontStyle.label, fullText: wordCategory.name)
        guard let label = self.label else {
            return
        }
        contentView.embed(view: label)
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = AppTheme.Main.Color.background
        contentView.backgroundColor = AppTheme.Main.Color.background
    }
}
