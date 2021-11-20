//
//  MainContainerViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 15.11.2021.
//

import UIKit

class MainContainerViewController: UIViewController {
    // MARK: - Private properties
    private var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    // MARK: - DI
    var presenter: MainContainerPresenterType!
    var contentViewController: UIViewController!
    // MARK: - UI
    lazy var collectionView: BaseCollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = BaseCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.contentInset.left = 24
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    lazy var searchContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.placeholder = "Find recipe"
        self.searchContentView.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchTextField
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brandColor
        button.setImage(UIImage.Icons.loupe, for: .normal)
        self.searchContentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var readyToCookLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle).withSize(24)
        label.numberOfLines = 1
        label.text = "Ready to cook?"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Hello" // TODO: - Нужно добавить имя из CoreData
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icons.userAvatar
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: - Lifecycle
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
        if data.name == presenter.selectedCategoryName {
            categoryCell.configureForSelectionState(name: data.name, imageURL: URL(string: data.imageURL ?? ""))
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            selectedIndexPath = indexPath
        } else {
            categoryCell.configure(name: data.name, imageURL: URL(string: data.imageURL ?? ""))
        }
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension MainContainerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = presenter.categories[indexPath.row]
        presenter.selectedCategoryName = selectedCategory.name
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as?
                CategoryCollectionViewCell else { return }
        selectedCell.selectOrDeselect(isSelected: true)
        if let oldCell = (collectionView.cellForItem(at: selectedIndexPath) as?
                            CategoryCollectionViewCell) {
            oldCell.selectOrDeselect(isSelected: false)
        }
        self.selectedIndexPath = indexPath
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath != self.selectedIndexPath {
            if cell.contentView.backgroundColor != .white {
                cell.contentView.backgroundColor = .white
            }
        }
    }
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
        addContentController(contentViewController)
        setupSubviews()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize
            = UICollectionViewFlowLayout.automaticSize
        self.view.backgroundColor = #colorLiteral(red: 0.8342786815, green: 0.8990528682, blue: 0.9208850599, alpha: 1)
    }
    func setupSubviews() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35),
            avatarImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            avatarImageView.widthAnchor.constraint(equalToConstant: 36),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            helloLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            helloLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            helloLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            readyToCookLabel.topAnchor.constraint(equalTo: self.helloLabel.bottomAnchor),
            readyToCookLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            readyToCookLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentViewController.view.topAnchor, constant: 5),
            collectionView.heightAnchor.constraint(equalToConstant: 55)
        ])
        NSLayoutConstraint.activate([
            searchContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            searchContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            searchContentView.topAnchor.constraint(equalTo: self.readyToCookLabel.bottomAnchor, constant: 8),
            searchContentView.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -8),
            searchContentView.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: self.searchContentView.leadingAnchor, constant: 10),
            searchTextField.topAnchor.constraint(equalTo: self.searchContentView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: self.searchContentView.bottomAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: self.searchContentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: self.searchContentView.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: self.searchContentView.bottomAnchor),
            searchButton.trailingAnchor.constraint(equalTo: self.searchContentView.trailingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40)
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
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
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
