//
//  LabelCell.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit

class LabelCell: UITableViewCell {
    
    //MARK: - Variables

    static let identifier = String(describing: LabelCell.self)
    
    // MARK: - Views

    lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        contentView.addSubview(label)

        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -4),
            label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -4)
        ])
    }
    
    //MARK: - Setup
    
    func configure(with model: LabelCellModel) {
        label.text = model.label
    }
}
