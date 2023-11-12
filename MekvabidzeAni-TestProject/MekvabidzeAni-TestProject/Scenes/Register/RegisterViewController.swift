//
//  RegisterViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Variables
    
    private var viewModel: RegisterViewModel
    private var emailText: String { emailTextField.textField.text.notNil }
    private var ageText: String { ageTextField.textField.text.notNil }
    private var passwordText: String { passwordTextField.textField.text.notNil }
    private var emailTag: Int { 1 }
    private var ageTag: Int { 2 }
    private var passwordTag: Int { 3 }
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, ageTextField, passwordTextField, registerButton])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var emailTextField: CustomTextField = .init(model: .init(placeholder: "Email",
                                                                          tag: emailTag,
                                                                          delegate: self,
                                                                          status: .normal))
    
    private lazy var ageTextField: CustomTextField = .init(model: .init(placeholder: "Age",
                                                                        tag: ageTag,
                                                                        delegate: self,
                                                                        status: .normal))
    
    private lazy var passwordTextField: CustomTextField = .init(model: .init(placeholder: "Password",
                                                                             tag: passwordTag,
                                                                             delegate: self,
                                                                             status: .normal))
    
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(model: .init(title: "REGISTER"))
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    public init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

   // MARK: - Lifecycle

extension RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

   //MARK: - Setup

extension RegisterViewController {
    private func setupAppearance() {
        title = "Register"
        view.backgroundColor = .systemBackground
        buildSubviews()
        buildConstraints()
    }
    
    private func buildSubviews() {
        view.addSubview(stackView)
    }
    
    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
}

   //MARK: - Helper

extension RegisterViewController {
    @objc private func registerButtonTapped() {
        // dismiss the keyboard
        emailTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        var validationSuccess: Bool = true
        
        validateEmail(validationSuccess: &validationSuccess)
        validateAge(validationSuccess: &validationSuccess)
        validatePassword(validationSuccess: &validationSuccess)
        
        if validationSuccess {
            registerUser()
        }
    }
    
    func validateEmail(validationSuccess: inout Bool) {
        let status = viewModel.validateEmail(emailText)
        switch status {
        case .success:
            emailTextField.setStatus(.normal)
        case .empty:
            emailTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        case .notValid:
            emailTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        }
    }
    
    func validateAge(validationSuccess: inout Bool) {
        let status = viewModel.validateAge(ageText)
        switch status {
        case .success:
            ageTextField.setStatus(.normal)
        case .empty:
            ageTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        case .notValid:
            ageTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        }
    }
    
    func validatePassword(validationSuccess: inout Bool) {
        let status = viewModel.validatePassword(passwordText)
        switch status {
        case .success:
            passwordTextField.setStatus(.normal)
        case .empty:
            passwordTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        case .notValid:
            passwordTextField.setStatus(.error(status.errorMessage))
            validationSuccess = false
        }
    }
   
    private func registerUser() {
        viewModel.register(email: emailText,
                           age: ageText,
                           password: passwordText) { [weak self] success in
            if success {
                self?.toPhotoGallery()
            } else {
                self?.showSimpleAlert(message: "Error Acquired")
            }
        }
    }
     
    //MARK: - Navigation
    
    private func toPhotoGallery() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate {
            let vc = PhotoGalleryViewController()
            let nc = UINavigationController(rootViewController: vc)
            sceneDelegate.changeRootViewController(nc)
        }
    }
}
    

   //MARK: - Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == emailTag {
            emailTextField.textField.resignFirstResponder()
            ageTextField.textField.becomeFirstResponder()
        } else if textField.tag == ageTag {
            ageTextField.textField.resignFirstResponder()
            passwordTextField.textField.becomeFirstResponder()
        } else if textField.tag == passwordTag {
            registerButtonTapped()
        }
        return true
    }
}
