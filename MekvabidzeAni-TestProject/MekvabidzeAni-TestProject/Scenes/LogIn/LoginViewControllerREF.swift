//
//  LoginViewControllerREF.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class LoginViewControllerREF: UIViewController {
    
    //MARK: - Variables
    
    private var viewModel: LoginViewModelREF
    private var email: String { emailTextField.text ?? "" }
    private var password: String { passwordTextField.text ?? "" }
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, registerButton])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //test commit
    private lazy var emailTextField: CustomTextField = .init(model: .init(placeholder: "Email",
                                                                          delegate: self,
                                                                          status: .normal))
    
    private lazy var passwordTextField: CustomTextField = .init(model: .init(placeholder: "Password",
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
    
    public init(viewModel: LoginViewModelREF) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    //MARK: - LifeCycle

extension LoginViewControllerREF {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

    //MARK: - Setup

extension LoginViewControllerREF {
    private func setupAppearance() {
        navigationController?.title = "Login"
        self.view.backgroundColor = .systemBackground
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

extension LoginViewControllerREF {
    @objc private func loginButtonTapped() {
        // to dismiss keyboard
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        let vc = PhotoGalleryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
//        if checkInputs() {
//            if CheckValidation.isValidEmail(email) {
//                if CheckValidation.isValidPassword(password) {
//                    loginUser()
//                } else {
////                    passwordTextField.setStatus(.error("Password not Valid"))
//                    self.showAlert(with: "Password not Valid")
//                }
//            } else {
////                emailTextField.setStatus(.error("Email not Valid"))
//                self.showAlert(with: "Email not Valid")
//            }
//        } else {
//            showAlert(with: "Feel All Fields")
//        }
    }
    
    @objc private func registerButtonTapped() {
        let vc = RegisterViewControllerREF(
            viewModel: DefaultRegisterViewModel.init(
                with: RegisterUseCaseImp(
                    repository: AuthorizationRepositoryImp(
                        coreDataManager: CoreDataManager()))))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loginUser() {
        viewModel.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                let vc = PhotoGalleryViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                if error == .userNotFound {
                    self?.showAlert(with: "Something went wrong, username or passcode is incorrect!")
                }
                if error == .unknownError {
                    self?.showAlert(with: "User was never registered")
                }
            }
        }
    }
    
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

    //MARK: - Delegate

extension LoginViewControllerREF: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            loginButtonTapped()
        }
        return true
    }
}
