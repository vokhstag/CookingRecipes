//
//  ImageCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 04.12.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    // MARK: - Visible methods
    func configure(url: URL?) {
        guard let url = url else { return }
        imageView.setImage(from: url)
    }
}
// MARK: - Setup
private extension ImageCell {
    func setup() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
