//
//  CustomTextField.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, errorLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = label.font.withSize(12)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    init(model: CustomTextFieldModel) {
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

extension CustomTextField {
    private func setupAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        buildSubviews()
        buildConstraints()
    }
    
    private func buildSubviews() {
        addSubview(stackView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
}

    //MARK: - Configure

extension CustomTextField {
    func configure(with model: CustomTextFieldModel) {
        textField.placeholder = model.placeholder
        textField.delegate = model.delegate
        configureStatus(status: model.status)
    }
    
    private func configureStatus(status: CustomTextFieldModel.Status) {
        switch status {
        case .error(let message):
            errorLabel.isHidden = false
            errorLabel.text = message
        default:
            errorLabel.isHidden = true
            errorLabel.text = ""
        }
    }
}

    //MARK: - Helper

extension CustomTextField {
    func setStatus(_ status: CustomTextFieldModel.Status) {
        configureStatus(status: status)
    }
}
