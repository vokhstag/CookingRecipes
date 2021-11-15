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
  //  private let presenter = MainContainerPresenter()
    // MARK: - UI
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.collectionViewLayout = collectionViewLayout
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
    }

}

// MARK: - UICollectionView DataSource
extension MainContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,
                                                      for: indexPath)
        cell.backgroundColor = .blue
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
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 100, height: 40)
        return size
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
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
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
