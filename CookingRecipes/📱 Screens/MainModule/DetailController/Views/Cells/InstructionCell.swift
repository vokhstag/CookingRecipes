//
//  InstructionCell.swift
//  CookingRecipes
//
//  Created by Yunus Abubakarov on 21.11.2021.
//

import UIKit

class InstructionCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    // MARK: - UI
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Instruction"
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Constructor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    func configure(with text: String) {
        self.instructionLabel.text = text
    }
}
// MARK: - Setup
private extension InstructionCell {
    func setup() {
        setupUI()
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            instructionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            instructionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            instructionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
