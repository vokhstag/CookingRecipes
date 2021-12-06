//
//  MediaCollectionView.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 04.12.2021.
//

import UIKit

class MediaCollectionView: UIView {
    // MARK: - Private properties
    private lazy var layoutCollection: WLCollectionViewLayout = {
        let layoutCollection = WLCollectionViewLayout()
        layoutCollection.minimumLineSpacing = 0
        layoutCollection.scrollDirection = .horizontal
        return layoutCollection
    }()
    // MARK: - UI
    lazy var mediaCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layoutCollection)
        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCell.self,
                                forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.register(VideoCell.self,
                                forCellWithReuseIdentifier: VideoCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    var gradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.updateLocations()
        gradientView.endColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6003159247)
        gradientView.startColor = .clear
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()
    var pageControll: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .brandColor
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    // MARK: - Visible properties
    var media: [URL]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updatePageControll()
                self?.mediaCollectionView.reloadData()
            }
        }
    }
    var collectionViewTapped: (() -> Void)?
    var collectionViewTappedWithIndex: ((Int) -> Void)?
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
        layoutSetup()
    }
}
// MARK: - UICollectionView DataSource
extension MediaCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier,
                                                           for: indexPath) as? ImageCell
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier,
                                                           for: indexPath) as? VideoCell
        switch indexPath.row {
        case 0:
            guard let cell = imageCell else { return UICollectionViewCell() }
            cell.configure(url: media?[indexPath.row])
            return cell
        case 1:
            guard let cell = videoCell else { return UICollectionViewCell() }
            cell.configure(url: media?[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
}
// MARK: - UICollectionViewDelegate
extension MediaCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        pageControll.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? ImageCell {
            collectionViewTapped?()
            collectionViewTappedWithIndex?(indexPath.row)
        }
    }
}
// MARK: - Setup
private extension MediaCollectionView {
    func setup() {
        NSLayoutConstraint.activate([
            mediaCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mediaCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mediaCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            mediaCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func setupPageControll() {
        addSubview(gradientView)
        addSubview(pageControll)
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            pageControll.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControll.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControll.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    func updatePageControll() {
        setupPageControll()
        pageControll.numberOfPages = media?.count ?? 1
        pageControll.hidesForSinglePage = true
        gradientView.isHidden = pageControll.isHidden
    }
    func layoutSetup() {
        layoutCollection.minimumLineSpacing = 0
        mediaCollectionView.isPagingEnabled = false
        layoutCollection.scrollDirection = .horizontal
        mediaCollectionView.layoutIfNeeded()
        mediaCollectionView.clipsToBounds = true
        mediaCollectionView.collectionViewLayout = layoutCollection
        let itemSize = mediaCollectionView.bounds.size
        layoutCollection.itemSize = itemSize

        mediaCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        mediaCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mediaCollectionView.reloadData()
    }
}
