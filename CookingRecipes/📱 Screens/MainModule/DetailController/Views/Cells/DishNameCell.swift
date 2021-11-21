//
//  DishNameCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import UIKit

class DishNameCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    lazy var dishCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    // MARK: - Constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    func configure(url: URL?, name: String?, country: String?) {
        dishNameLabel.text = name
        dishCountryLabel.text = country
        if let url = url {
            dishImageView.setImage(from: url)
        }
    }
}
// MARK: - Setup
private extension DishNameCell {
    func setup() {
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: self.topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            dishImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 13),
            dishImageView.heightAnchor.constraint(equalTo: dishImageView.widthAnchor, multiplier: 0.75)
        ])
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dishNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 20)
        ])
        let dishBottomAnchor = dishNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
        dishBottomAnchor.priority = UILayoutPriority(250)
        dishBottomAnchor.isActive = true
        NSLayoutConstraint.activate([
            dishCountryLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: 1),
            dishCountryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dishCountryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dishCountryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
