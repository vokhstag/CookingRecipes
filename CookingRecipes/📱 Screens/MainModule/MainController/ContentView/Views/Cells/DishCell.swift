//
//  DishCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 18.11.2021.
//

import UIKit

class DishCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var subContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        return imageView
    }()
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        subContentView.addSubview(label)
        return label
    }()
    lazy var dishCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        subContentView.addSubview(label)
        return label
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
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width/2
    }
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    func configure(name: String, country: String, imageURL: URL?) {
        dishNameLabel.text = name
        dishCountryLabel.text = country
        if let url = imageURL {
            imageView.setImage(from: url)
            imageView.clipsToBounds = true
        }
    }
}
// MARK: - Setup
private extension DishCell {
    func setup() {
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            subContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subContentView.heightAnchor.constraint(equalTo: subContentView.widthAnchor, multiplier: 1.15)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerYAnchor.constraint(equalTo: subContentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: subContentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: subContentView.widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            dishNameLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 6),
            dishNameLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -6)
        ])
        NSLayoutConstraint.activate([
            dishCountryLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 1),
            dishCountryLabel.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 6),
            dishCountryLabel.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -6),
            dishCountryLabel.bottomAnchor.constraint(lessThanOrEqualTo: subContentView.bottomAnchor, constant: -10)
        ])
    }
}
