//
//  IngredientViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 23.11.2021.
//

import UIKit

class IngredientViewController: UIViewController {
    // MARK: - DI
    var presenter: IngredientPresenterProtocol!
    // MARK: - UI
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    lazy var measureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Setup
private extension IngredientViewController {
    func setup() {
        self.view.backgroundColor = .white
        setupUI()
        configure()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([
            measureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            measureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: measureLabel.leadingAnchor, constant: 8)
        ])
    }
    func configure() {
        if let url = presenter.imageURL {
            imageView.setImage(from: url)
        }
        nameLabel.text = presenter.name
        measureLabel.text = presenter.measure
    }
}
