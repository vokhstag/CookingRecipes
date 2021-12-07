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
    var mediaView: MediaCollectionView = {
        let mediaView = MediaCollectionView()
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        return mediaView
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
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        mediaView.layer.cornerRadius = 16
    }
    // MARK: - Configure
    func configure(url: URL?, videoURL: URL?, name: String?, country: String?) {
        dishNameLabel.text = name
        dishCountryLabel.text = country
        var mediaURLs: [URL] = []
        if let url = url {
            mediaURLs.append(url)
            mediaView.clipsToBounds = true
        }
        if let videoUrl = videoURL {
            mediaURLs.append(videoUrl)
        }
        mediaView.media = mediaURLs
    }
}
// MARK: - Setup
private extension DishNameCell {
    func setup() {
        self.layoutIfNeeded()
        setupUI()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    func setupUI() {
        self.addSubview(mediaView)
        NSLayoutConstraint.activate([
            mediaView.topAnchor.constraint(equalTo: self.topAnchor),
            mediaView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            mediaView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13),
            mediaView.heightAnchor.constraint(equalTo: mediaView.widthAnchor, multiplier: 0.75)
        ])
        NSLayoutConstraint.activate([
            dishNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dishNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dishNameLabel.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 20)
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
