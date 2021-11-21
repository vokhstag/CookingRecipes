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
        self.view.addSubview(tableView)
        return tableView
    }()
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Instruction"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var instructionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var ingredients: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Ingredients"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Setup
private extension DetailViewController {
    func setup() {
    }
}
