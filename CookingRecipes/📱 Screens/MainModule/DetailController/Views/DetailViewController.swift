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
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .brandWhite
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DishNameCell.self, forCellReuseIdentifier: DishNameCell.identifier)
        tableView.register(InstructionCell.self, forCellReuseIdentifier: InstructionCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        return tableView
    }()
    lazy var addToFavoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage.TabBarIcons.bookmark,
                                     style: .plain, target: self,
                                     action: #selector(addToFavoriteButtonTapped))
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - UITableView DataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var number = 1
        number = (presenter.dish.instructions == nil) ? number : number + 1
        number = (presenter.dish.allIngredients().isEmpty) ? number : number + 1
        return number
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return presenter.dish.allIngredients().count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = presenter.dish
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DishNameCell.identifier,
                                                           for: indexPath) as? DishNameCell
            else { return UITableViewCell() }
            let imageURL = URL(string: data.imageUrl ?? "")
            let videoURL = URL(string: data.youtube ?? "")
            cell.configure(url: imageURL, videoURL: videoURL, name: data.name, country: data.country)
            return cell
        case 1:
            if data.instructions == nil {
                fallthrough
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionCell.identifier,
                                                           for: indexPath) as? InstructionCell
            else {
                return UITableViewCell()
            }
            cell.configure(with: data.instructions ?? "")
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier,
                                                           for: indexPath) as? IngredientCell
            else { return UITableViewCell() }
            let ingredient = data.allIngredients()[indexPath.row]
            let measure = data.allMeasures()[indexPath.row]
            let url = Endpoints.ingredientImage(ingredient: ingredient).url
            cell.configure(imageURL: url, name: ingredient, measure: measure)
            return cell
        default: return UITableViewCell()
        }
    }
}
// MARK: - UITableView Delegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) as? IngredientCell != nil else { return }
        let name = presenter.dish.allIngredients()[indexPath.row]
        let measure = presenter.dish.allMeasures()[indexPath.row]
        presenter.goToIngredients(name: name, measure: measure)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView()
        switch section {
        case 0:
            return UIView()
        case 1:
            let title = (presenter.dish.instructions == nil) ? "Ingredients" : "Instruction"
            headerView.titleLabel.text = title
            return headerView
        case 2:
            headerView.titleLabel.text = "Ingredients"
            return headerView
        default:
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
        case 1, 2:
            return 58
        default:
            return 0
        }
    }
}
// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func dishAddedToFavorite() {
        let image = UIImage.TabBarIcons.bookmarkSelected
        self.addToFavoriteButton.image = image
    }
    func dishRemovedFromFavorite() {
        let image = UIImage.TabBarIcons.bookmark
        self.addToFavoriteButton.image = image
    }
    func failure(errorDescription: String) {
        showErrorAlert(message: errorDescription)
    }
}
// MARK: - Setup
private extension DetailViewController {
    func setup() {
        self.navigationController?.navigationBar.isHidden = false
        setupUI()
        setupNavigationBar()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    func setupNavigationBar() {
        let image = (presenter.isFavoriteDish()) ? UIImage.TabBarIcons.bookmarkSelected : UIImage.TabBarIcons.bookmark
        self.addToFavoriteButton.image = image
        self.navigationItem.rightBarButtonItem  = addToFavoriteButton
    }
}
// MARK: - Private methods
private extension DetailViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    @objc func addToFavoriteButtonTapped() {
        if presenter.isFavoriteDish() {
            presenter.removeDishFromFavorite()
        } else {
            presenter.saveDish()
        }
    }
}
