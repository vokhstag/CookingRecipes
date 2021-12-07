//
//  GradientView.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 04.12.2021.
//

import UIKit

class GradientView: UIView {
    // MARK: - Visible properties
    var startColor: UIColor = .black { didSet { updateColors() }}
    var endColor: UIColor = .white { didSet { updateColors() }}
    var startLocation: Double =   0.1 { didSet { updateLocations() }}
    var endLocation: Double =   0.9 { didSet { updateLocations() }}
    var horizontalMode: Bool =  false { didSet { updatePoints() }}
    var diagonalMode: Bool =  false { didSet { updatePoints() }}
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    var gradientLayer: CAGradientLayer { return (layer as? CAGradientLayer) ?? CAGradientLayer() }
    // MARK: - Visible methods
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    // MARK: - lifecycle
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
