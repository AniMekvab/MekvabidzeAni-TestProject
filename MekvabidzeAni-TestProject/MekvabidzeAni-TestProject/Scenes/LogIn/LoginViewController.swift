//
//  LoginViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Variables
    
    private var viewModel: LoginViewModel
    private var emailText: String { emailTextField.textField.text.notNil }
    private var passwordText: String { passwordTextField.textField.text.notNil }
    private var emailTag: Int { 1 }
    private var passwordTag: Int { 2 }
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, registerButton])
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
    
    private lazy var passwordTextField: CustomTextField = .init(model: .init(placeholder: "Password",
                                                                             tag: passwordTag,
                                                                             delegate: self,
                                                                             status: .normal))
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(model: .init(title: "LOGIN"))
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: CustomButton = {
        let button = CustomButton(model: .init(title: "REGISTER"))
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    //MARK: - LifeCycle

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

    //MARK: - Setup

extension LoginViewController {
    private func setupAppearance() {
        title = "Login"
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

extension LoginViewController {
    @objc private func loginButtonTapped() {
        // to dismiss keyboard
        passwordTextField.textField.resignFirstResponder()
        emailTextField.textField.resignFirstResponder()
        
        var validationSuccess: Bool = true
        
        validateEmail(validationSuccess: &validationSuccess)
        validatePassword(validationSuccess: &validationSuccess)
        
        if validationSuccess {
            loginUser()
        }
    }
    
    @objc private func registerButtonTapped() {
        toRegister()
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
    
    private func loginUser() {
        viewModel.login(email: emailText, password: passwordText) { [weak self] result in
            switch result {
            case .success:
                self?.toPhotoGallery()
            case .failure(let error):
                switch error {
                case .userNotFound:
                    self?.showSimpleAlert(title: "Error", message: "Something went wrong, username or passcode is incorrect!")
                case .unknownError:
                    self?.showSimpleAlert(title: "Error", message: "User was never registered")
                }
            }
        }
    }
    
    //MARK: - Navigation
    
    private func toPhotoGallery() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate {
            let vc = GalleryViewController()
            let nc = UINavigationController(rootViewController: vc)
            sceneDelegate.changeRootViewController(nc)
        }
    }
    
    private func toRegister() {
        let vc = RegisterViewController(
            viewModel: DefaultRegisterViewModel.init(
                registerUseCase: RegisterUseCaseImp(
                    repository: AuthorizationRepositoryImp(
                        coreDataManager: CoreDataManager()))))
        navigationController?.pushViewController(vc, animated: true)
    }
}

    //MARK: - Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == emailTag {
            emailTextField.textField.resignFirstResponder()
            passwordTextField.textField.becomeFirstResponder()
        } else if textField.tag == passwordTag {
            loginButtonTapped()
        }
        return true
    }
}
