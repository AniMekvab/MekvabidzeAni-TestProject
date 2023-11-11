//
//  RegisterViewControllerREF.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import UIKit

class RegisterViewControllerREF: UIViewController {
    
    // MARK: - Variables
    
    private var viewModel: RegisterViewModel
    private var email: String { emailTextField.text ?? "" }
    private var age: String { ageTextField.text ?? "" }
    private var password: String { passwordTextField.text ?? "" }
    
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
                                                                          delegate: self,
                                                                          status: .normal))
    
    private lazy var ageTextField: CustomTextField = .init(model: .init(placeholder: "Email",
                                                                        delegate: self,
                                                                        status: .normal))
    
    private lazy var passwordTextField: CustomTextField = .init(model: .init(placeholder: "Password",
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

extension RegisterViewControllerREF {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}

   //MARK: - Setup

extension RegisterViewControllerREF {
    private func setupAppearance() {
        navigationController?.title = "Register"
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

extension RegisterViewControllerREF {
    @objc private func registerButtonTapped() {
        // dismiss the keyboard
        emailTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if checkInputs() {
            if CheckValidation.isValidEmail(email) {
                if CheckValidation.isValidAge(Int(age) ?? 0) {
                    if CheckValidation.isValidPassword(password) {
                        registerUser()
                    } else {
                        self.showAlert(with: "Password not Valid")
                    }
                } else {
                    self.showAlert(with: "Age not Valid")
                }
            } else {
                self.showAlert(with: "Mail not Valid")
            }
        } else {
            self.showAlert(with: "Feel All Fields")
        }
    }
   
    private func registerUser() {
        if viewModel.registration(email: email, age: age, password: password) == true {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoGalleryViewController") as? PhotoGalleryViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
     
     // MARK: - Navigation Method
    
     private func popToWelcomePage(){
        self.navigationController?.popViewController(animated: true)
     }
}
    

   //MARK: - Delegate

extension RegisterViewControllerREF: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            ageTextField.becomeFirstResponder()
        }
        else if textField == ageTextField{
            passwordTextField.becomeFirstResponder()
        }
        else {
            registerButtonTapped()
        }
        return true
    }
}
