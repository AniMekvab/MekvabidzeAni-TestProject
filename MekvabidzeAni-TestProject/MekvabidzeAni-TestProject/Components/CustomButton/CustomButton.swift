//
//  CustomButton.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class CustomButton: UIButton {
    
    //MARK: - Init
    
    init(model: CustomButtonModel) {
        super.init(frame: .zero)
        configure(with: model)
        setupAppearance()
    }
    
    init() {
        super.init(frame: .zero)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    //MARK: - Setup

extension CustomButton {
    private func setupAppearance() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        buildConstraints()
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

    //MARK: - Configure

extension CustomButton {
    func configure(with model: CustomButtonModel) {
        setTitle(model.title, for: .normal)
    }
}
