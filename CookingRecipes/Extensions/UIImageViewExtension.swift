//
//  UIImageViewExtension.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 17.11.2021.
//

import UIKit

extension UIImageView {
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func setImage(from url: URL) {
        getData(from: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
