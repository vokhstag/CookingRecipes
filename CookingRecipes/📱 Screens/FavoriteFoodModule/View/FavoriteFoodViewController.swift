//
//  FavoriteFoodViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

class FavoriteFoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
private extension FavoriteFoodViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
}
