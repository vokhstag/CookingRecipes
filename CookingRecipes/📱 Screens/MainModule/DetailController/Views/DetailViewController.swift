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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DishNameCell.self, forCellReuseIdentifier: DishNameCell.identifier)
        tableView.register(InstructionCell.self, forCellReuseIdentifier: InstructionCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
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
            cell.configure(url: URL(string: data.imageUrl ?? ""), name: data.name, country: data.country)
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
// MARK: - Setup
private extension DetailViewController {
    func setup() {
        self.navigationController?.navigationBar.isHidden = false
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
