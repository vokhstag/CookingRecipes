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
    lazy private var imageContentView: UIView = {
        let view = UIView()
        view.isOpaque = false
        self.addSubview(view)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.10)
        return view
    }()
    lazy var ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageContentView.addSubview(imageView)
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
        self.backgroundColor = .clear
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            imageContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            imageContentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            imageContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            imageContentView.widthAnchor.constraint(equalToConstant: 60),
            imageContentView.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            ingredientImageView.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor, constant: 5),
            ingredientImageView.topAnchor.constraint(equalTo: imageContentView.topAnchor, constant: 5),
            ingredientImageView.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -5),
            ingredientImageView.trailingAnchor.constraint(equalTo: imageContentView.trailingAnchor, constant: -5)
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
