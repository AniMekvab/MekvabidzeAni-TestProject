//
//  LoginViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let emailTextField: UITextField = {
        SetUpUI.textField(placeholder: "Email")
    }()
    
    private let invalidEmailLabel: UILabel = {
        SetUpUI.label(text: "Email is invalid")
    }()
    
    private let passwordTextField: UITextField = {
        SetUpUI.textField(placeholder: "Password")
    }()
    
    private let invalidPasswordLabel: UILabel = {
        SetUpUI.label(text: "Password is invalid")
    }()
    
    private let loginButton: UIButton = {
        SetUpUI.button(title: "Log In")
    }()

    private let registerButton: UIButton = {
        SetUpUI.button(title: "Register")
    }()
    
    private var coreDataManager: CoreDataManagerProtocol!
    private var viewModel: LoginViewModelProtocol!
    
    private var email: String { emailTextField.text ?? "" }
    private var password: String { passwordTextField.text ?? "" }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addSubviews()
        
        configureViewModel()
    }

    override func viewDidLayoutSubviews() {
        //assign frames
        emailTextField.frame = CGRect(
            x: 25,
            y: view.safeAreaInsets.top + 12,
            width: view.width - 50,
            height: 48)
        
        invalidEmailLabel.frame = CGRect(
            x: 27,
            y: emailTextField.bottom + 2,
            width: view.width - 50,
            height: 12.0)
        
        passwordTextField.frame = CGRect(
            x: 25,
            y: invalidEmailLabel.bottom + 8,
            width: view.width - 50,
            height: 48)
        
        invalidPasswordLabel.frame = CGRect(
            x: 27,
            y: passwordTextField.bottom + 2,
            width: view.width - 50,
            height: 12.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: invalidPasswordLabel.bottom + 24,
            width: view.width - 50,
            height: 48)
        
        registerButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 48)
            
    }
    
    // MARK: - Setup
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(invalidEmailLabel)
        view.addSubview(passwordTextField)
        view.addSubview(invalidPasswordLabel)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    
    
    @objc private func loginButtonTapped() {
        // to dismiss keyboard
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        if checkInputs() {
            if CheckValidation.isValidEmail(email) {
                if CheckValidation.isValidPassword(password) {
                    loginUser()
                } else {
                    self.showAlert(with: "Password not Valid")
                }
            } else {
                self.showAlert(with: "Email not Valid")
            }
        } else {
            showAlert(with: "Feel All Fields")
        }
    }
    
    @objc private func registerButtonTapped() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    private func configureViewModel() {
        coreDataManager = CoreDataManager()
        viewModel = LoginViewModel(with: coreDataManager)
    }
    
    private func loginUser() {
        viewModel.login(email: email, password: password) { result in
            switch result {
            case .success(_):
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoGalleryViewController") as? PhotoGalleryViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case .failure(let error):
                if error == .userNotFound {
                    self.showAlert(with: "Something went wrong, username or passcode is incorrect!")
                }
                if error == .unknownError {
                    self.showAlert(with: "User was never registered")
                }
            }
        }
    }
    
    // MARK: - Registration Validations
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

extension LoginViewController: UITextFieldDelegate{
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
