//
//  MainViewController.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
}
