//
//  DetailViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: DI
    var presenter: DetailPresenterType!
    // MARK: - UI
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .brandWhite
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.scrollView.addSubview(imageView)
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var dishNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(label)
        return label
    }()
    lazy var dishCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(label)
        return label
    }()
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Instruction"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(label)
        return label
    }()
    lazy var instructionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(label)
        return label
    }()
    lazy var ingredients: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Ingredients"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(label)
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
