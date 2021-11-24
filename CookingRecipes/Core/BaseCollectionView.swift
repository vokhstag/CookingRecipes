//
//  BaseCollectionView.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 17.11.2021.
//

import UIKit

class BaseCollectionView: UICollectionView {
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.setupLoadingView()
        }
    }
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: Setup
private extension BaseCollectionView {
    func setupLoadingView() {
        self.addSubview(activityIndicator)
        activityIndicator.color = .brandColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
}
