//
//  FavoriteFoodViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

class FavoriteFoodViewController: UIViewController {
    // MARK: - DI
    var presenter: FavoriteFoodPresenterProtocol!
    // MARK: - UI
    lazy var collectionView: BaseCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumInteritemSpacing = 16
        collectionViewLayout.minimumLineSpacing = 20
        let collectionView = BaseCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.collectionViewLayout = collectionViewLayout
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset.top = 32
        collectionView.contentInset.left = 24
        collectionView.contentInset.right = 24
        collectionView.register(DishCell.self,
                                forCellWithReuseIdentifier: DishCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

}
// MARK: - UICollectionView DataSource
extension FavoriteFoodViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.dishes.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.identifier, for: indexPath)
        guard let dishCell = cell as? DishCell else { return cell }
        let data = presenter.dishes[indexPath.row]
        dishCell.configure(name: data.name ?? "",
                           country: data.country ?? "",
                           imageURL: URL(string: data.imageUrl ?? ""))
        return dishCell
    }
}

// MARK: - UICollectionView Delegate
extension FavoriteFoodViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = presenter.dishes[indexPath.row]
        presenter.goToDetailRecipe(dish: dish)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteFoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 70)/2
        let cellHeight = cellWidth * 1.45
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - Setup
private extension FavoriteFoodViewController {
    func setup() {
        self.view.backgroundColor = .brandWhite
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
