//
//  VideoCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 04.12.2021.
//

import UIKit
import WebKit

class VideoCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var videoWebView: WKWebView = {
        let videoWebView = WKWebView()
        self.addSubview(videoWebView)
        videoWebView.translatesAutoresizingMaskIntoConstraints = false
        return videoWebView
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
        print(url)
        videoWebView.load(URLRequest(url: url))
    }
}
// MARK: - Setup
private extension VideoCell {
    func setup() {
        NSLayoutConstraint.activate([
            videoWebView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoWebView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            videoWebView.topAnchor.constraint(equalTo: self.topAnchor),
            videoWebView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
