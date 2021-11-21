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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DishNameCell.self, forCellReuseIdentifier: DishNameCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: InstructionCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
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
            if data.instructions != nil {
                fallthrough
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionCell.identifier,
                                                           for: indexPath) as? InstructionCell
            else { return UITableViewCell() }
            cell.configure(with: data.instructions ?? "")
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier,
                                                           for: indexPath) as? IngredientCell
            else { return UITableViewCell() }
            let ingredient = data.allIngredients()[indexPath.row]
            let measure = data.allMeasures()[indexPath.row]
            let url = Endpoints.ingredientImage(ingredient: ingredient).url
            cell.configure(imageURL: url, name: ingredient, measure: measure)
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
}
// MARK: - Setup
private extension DetailViewController {
    func setup() {
    }
}
