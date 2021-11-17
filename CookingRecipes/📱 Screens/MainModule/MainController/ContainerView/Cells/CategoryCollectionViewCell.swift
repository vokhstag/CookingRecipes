//
//  CategoryCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 10.11.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    lazy private var imageContentView: UIView = {
        let view = UIView()
        view.isOpaque = false
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        return view
    }()
    lazy private var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        self.imageContentView.addSubview(imageView)
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
    func configure(name: String, imageURL: URL?) {
        nameLabel.text = name
        if let url = imageURL {
            categoryImageView.setImage(from: url)
        }
    }
}

// MARK: - Setup
private extension CategoryCollectionViewCell {
    func setup() {
        self.contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        setupSubviews()
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            imageContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            imageContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            imageContentView.widthAnchor.constraint(equalTo: imageContentView.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            categoryImageView.centerYAnchor.constraint(equalTo: self.imageContentView.centerYAnchor),
            categoryImageView.centerXAnchor.constraint(equalTo: self.imageContentView.centerXAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 20),
            categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.imageContentView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          //  label.topAnchor.constraint(equalTo: self.topAnchor, constant: 3)
        ])
    }
}
