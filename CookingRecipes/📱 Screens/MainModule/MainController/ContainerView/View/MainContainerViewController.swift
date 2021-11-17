//
//  MainContainerViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import UIKit

class MainContainerViewController: UIViewController {
    // MARK: - Private properties
    private let contentViewConrtoller = MainViewController()
    // MARK: - DI
    var presenter: MainContainerPresenterType!
    // MARK: - UI
    lazy var collectionView: BaseCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = BaseCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.contentInset.left = 12
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        label.text = "Категории"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.startLoading()
        presenter.getCategories()
    }
}

// MARK: - UICollectionView DataSource
extension MainContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.categories.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,
                                                      for: indexPath)
        guard let categoryCell = cell as? CategoryCollectionViewCell else { return cell }
        let data = presenter.categories[indexPath.row]
        if let imageURL = data.imageURL {
            categoryCell.configure(name: data.name, imageURL: URL(string: imageURL))
        }
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension MainContainerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionView DelegateFlowLayout
extension MainContainerViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: 120, height: 36)
//        return size
//    }
}

// MARK: - MainContainerViewProtocol
extension MainContainerViewController: MainContainerViewProtocol {
    func succes() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.stopLoading()
            self?.collectionView.reloadData()
        }
    }
    func failure(errorDescription: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showErrorAlert(message: errorDescription)
        }
    }
}

// MARK: - Setup
private extension MainContainerViewController {
    func setup() {
        addContentController(contentViewConrtoller)
        setupHeaderLabel()
        setupCollectionView()
        self.view.backgroundColor = #colorLiteral(red: 0.8342786815, green: 0.8990528682, blue: 0.9208850599, alpha: 1)
    }
    func setupHeaderLabel() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentViewConrtoller.view.topAnchor, constant: 5)
        ])
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize
            = UICollectionViewFlowLayout.automaticSize
    }
    func addContentController(_ child: UIViewController) {
        addChild(child)
        self.view.addSubview(child.view)
        setupChildView(view: child.view)
        child.didMove(toParent: self)
    }
    func setupChildView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - Private methods
private extension MainContainerViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
