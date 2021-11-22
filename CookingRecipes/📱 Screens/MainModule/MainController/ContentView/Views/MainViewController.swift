//
//  MainViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: DI
    var presenter: MainViewPresenterProtocol!
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

}

// MARK: - UICollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
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
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = presenter.dishes[indexPath.row]
        presenter.goToDetailRecipe(dish: dish)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width - 70)/2
        let cellHeight = cellWidth * 1.45
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension MainViewController: MainViewProtocol {
    func load() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.startLoading()
        }
    }
    func succes() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.stopLoading()
            self?.collectionView.reloadData()
        }
    }
    func failure(errorDescription: String) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.stopLoading()
            self?.showErrorAlert(message: errorDescription)
        }
    }
}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        setupUI()
     //   self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
//        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize
//            = UICollectionViewFlowLayout.automaticSize
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
// MARK: - Private methods
private extension MainViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
