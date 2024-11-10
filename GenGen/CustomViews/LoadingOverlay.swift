//
//  LoadingOverlay.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import UIKit

class LoadingOverlay {
    static let shared = LoadingOverlay()
    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private lazy var label = GGLabel(
        textColor: AppTheme.Main.Color.buttonTitle,
        font:AppTheme.Main.FontStyle.buttonTitle
    )

    private init() {
        overlayView.backgroundColor = AppTheme.Main.Color.loadingOverlay
        activityIndicator.color = AppTheme.Main.Color.buttonTitle
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    func show(over viewController: UIViewController, message: String = Texts.loadingTitle) {
        guard let view = viewController.view else { return }
        label.setText(fullText: message)
        overlayView.frame = view.bounds
        view.addSubview(overlayView)

        activityIndicator.startAnimating()
        overlayView.addSubview(activityIndicator)
        overlayView.addSubview(label)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor)
        ])
    }

    func hide() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
