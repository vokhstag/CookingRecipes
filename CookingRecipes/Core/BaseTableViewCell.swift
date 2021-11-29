//
//  BaseTableViewCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
