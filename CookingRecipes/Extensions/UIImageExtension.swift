//
//  UIImageExtension.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 27.10.2021.
//

import UIKit

extension UIImage {
    enum Images {
        static var backroundImage: UIImage {
            return UIImage(named: "backroundImage")!
        }
    }
    enum Icons {
        static var loupe: UIImage {
            return UIImage(named: "loupe")!
        }
        static var userAvatar: UIImage {
            return UIImage(named: "userAvatar")!
        }
    }
    enum TabBarIcons {
        static var home: UIImage {
            return UIImage(named: "Home") ?? UIImage()
        }
        static var bookmark: UIImage {
            return UIImage(named: "Bookmark") ?? UIImage()
        }
        static var homeSelected: UIImage {
            return UIImage(named: "HomeSelected") ?? UIImage()
        }
        static var bookmarkSelected: UIImage {
            return UIImage(named: "BookmarkSelected") ?? UIImage()
        }
    }
}
