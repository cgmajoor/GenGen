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
    private var logoImageView = UIImageView()

    private lazy var label = GGLabel(
        textColor: AppTheme.Color.ggPink,
        font: AppTheme.Main.FontStyle.buttonTitle
    )

    private var gradientLayer = CAGradientLayer()

    private init() {
        overlayView.backgroundColor = AppTheme.Main.Color.loadingOverlay

        logoImageView.image = AppTheme.Navigation.Image.logo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        setupGradientLayer()
    }

    func show(over viewController: UIViewController, message: String = Texts.loadingTitle) {
        guard let view = viewController.view else { return }

        label.setText(fullText: message)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)

        overlayView.addSubview(logoImageView)
        overlayView.addSubview(label)

        startGradientAnimation()

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor)
        ])

        overlayView.layoutIfNeeded()
        updateGradientFrame()
    }

    func hide() {
        stopGradientAnimation()
        overlayView.removeFromSuperview()
    }

    private func setupGradientLayer() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        label.layer.mask = gradientLayer
    }

    private func updateGradientFrame() {
        gradientLayer.frame = overlayView.bounds
    }
}

// MARK: - Animation Extensions
extension LoadingOverlay {
    private func startGradientAnimation() {
        updateGradientFrame()

        let gradientAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        gradientAnimation.fromValue = -overlayView.bounds.width
        gradientAnimation.toValue = overlayView.bounds.width
        gradientAnimation.duration = 1.5
        gradientAnimation.repeatCount = .infinity

        gradientLayer.add(gradientAnimation, forKey: "slide")
    }

    private func stopGradientAnimation() {
        gradientLayer.removeAnimation(forKey: "slide")
    }
}
