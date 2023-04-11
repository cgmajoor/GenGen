//
//  RulesTableViewCell.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 10/04/2023.
//

import UIKit

protocol ActiveSwitchDelegate: NSObject {
    func didChangeValue(for cell: UITableViewCell, value: Bool)
}

class RulesTableViewCell: UITableViewCell {

    // MARK: - Properties
    weak var delegate: ActiveSwitchDelegate?
    
    // MARK: - UI
    private var label = GGLabel(textColor: AppTheme.RuleCreator.Color.actionForeground,
                                font: AppTheme.Main.FontStyle.label,
                                textAlignment: .left,
                                fullText: "")

    private lazy var activeSwitch: UISwitch = {
        let uiSwitch = UISwitch(frame: .zero)
        uiSwitch.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()

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
        label.setText(fullText: "")
        activeSwitch.isOn = false
        activeSwitch.isEnabled = false
    }

    func configure(ruleName: String, active: Bool) {
        label.removeFromSuperview()
        activeSwitch.removeFromSuperview()

        label.setText(fullText: ruleName)

        activeSwitch.isEnabled = true
        activeSwitch.setOn(active, animated: false)

        contentView.addSubview(label)
        contentView.addSubview(activeSwitch)

        let horizontalPadding = AppTheme.Main.Padding.horizontal
        let verticalPadding = AppTheme.Main.Padding.vertical

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20.0),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),

            activeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activeSwitch.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -horizontalPadding),
            activeSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            activeSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding)
        ])
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    // MARK: - Actions
    @objc func didChangeValue(_ sender: UISwitch) {
        delegate?.didChangeValue(for: self, value: sender.isOn)
    }
}
