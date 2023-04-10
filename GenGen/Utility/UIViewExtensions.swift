//
//  UIViewExtensions.swift
//  GenGen
//
//  Created by Ceren Gazioglu Majoor on 01/04/2023.
//

import UIKit

extension UIView {
    func embed(view subView: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }
    
    func embedToSafeArea(view subView: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top),
            subView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
            subView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            subView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -insets.right)
        ])
    }
}
