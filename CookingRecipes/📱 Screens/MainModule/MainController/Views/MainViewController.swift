//
//  MainViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

extension MainViewController: MainViewProtocol {
    func succes() {
        print(presenter.dishes?.first ?? "NIL")
    }
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
}
