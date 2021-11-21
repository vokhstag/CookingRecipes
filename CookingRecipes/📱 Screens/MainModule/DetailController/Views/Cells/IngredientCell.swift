//
//  IngredientCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import UIKit

class IngredientCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    lazy var measureLabel: UILabel = {
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
    func configure(imageURL: URL?, name: String, measure: String?) {
        nameLabel.text = name
        measureLabel.text = measure
        if let url = imageURL {
            ingredientImageView.setImage(from: url)
        }
    }
}
// MARK: - Setup
private extension IngredientCell {
    func setup() {
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            ingredientImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            ingredientImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            ingredientImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            ingredientImageView.widthAnchor.constraint(equalToConstant: 60),
            ingredientImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            measureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            measureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: ingredientImageView.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: measureLabel.leadingAnchor, constant: 8)
        ])
        
    }
}
