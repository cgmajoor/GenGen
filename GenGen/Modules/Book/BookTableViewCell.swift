//
//  BookTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 04/04/2023.
//

import UIKit

class BookTableViewCell: UITableViewCell {

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

    func configure(with wordTitle: String) {
        label?.removeFromSuperview()
        label = GGLabel(textColor: AppTheme.Main.Color.labelTitle, font: AppTheme.Main.FontStyle.label, fullText: wordTitle)
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
