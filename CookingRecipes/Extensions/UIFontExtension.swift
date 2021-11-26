//
//  UIFontExtension.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 26.11.2021.
//

import UIKit

extension UIFont {
    enum FontsType {
        static let loraBold = "Lora-Bold"
        static let nunitoBold = "Nunito-Bold"
        static let nunitoRegular = "Nunito-Regular"
    }
    enum CustomFonts {
        static var title1: UIFont {
            return UIFont(name: FontsType.loraBold, size: 40.0)!
        }
        static var title2: UIFont {
            return UIFont(name: FontsType.loraBold, size: 20.0)!
        }
        static var subhead1: UIFont {
            return UIFont(name: FontsType.nunitoBold, size: 16.0)!
        }
        static var subhead2: UIFont {
            return UIFont(name: FontsType.nunitoRegular, size: 15.0)!
        }
    }
}
