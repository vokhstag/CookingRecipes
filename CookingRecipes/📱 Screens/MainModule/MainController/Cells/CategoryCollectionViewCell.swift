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
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
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
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = self.contentView.bounds.height/2
    }
}

// MARK: - Setup
private extension CategoryCollectionViewCell {
    func setup() {
        self.backgroundColor = .white
        setupLabel()
    }
    func setupLabel() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 3)
        ])
    }
}
