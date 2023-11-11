//
//  RegisterViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    private let emailTextField: UITextField = {
        SetUpUI.textField(placeholder: "Email")
    }()
    
    private let invalidEmailLabel: UILabel = {
        SetUpUI.label(text: "Email is invalid")
    }()
    
    private let ageTextField: UITextField = {
        SetUpUI.textField(placeholder: "Age")
    }()
    
    private let invalidAgeLabel: UILabel = {
        SetUpUI.label(text: "Age is invalid")
    }()
    
    private let passwordTextField: UITextField = {
        SetUpUI.textField(placeholder: "Password")
    }()
    
    private let invalidPasswordLabel: UILabel = {
        SetUpUI.label(text: "Password is invalid")
    }()

    private let registerButton: UIButton = {
        SetUpUI.button(title: "Register")
    }()
    
    private var coreDataManager: CoreDataManagerProtocol!
//    private var viewModel: RegisterViewModelProtocol!
    
    private var email: String { emailTextField.text ?? "" }
    private var age: String { ageTextField.text ?? "" }
    private var password: String { passwordTextField.text ?? "" }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        emailTextField.delegate = self
        ageTextField.delegate = self
        passwordTextField.delegate = self
        
        addSubviews()
        
        configureViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        ageTextField.frame = CGRect(
            x: 25,
            y: invalidEmailLabel.bottom + 8,
            width: view.width - 50,
            height: 48)
        
        invalidAgeLabel.frame = CGRect(
            x: 27,
            y: ageTextField.bottom + 2,
            width: view.width - 50,
            height: 12.0)
        
        passwordTextField.frame = CGRect(
            x: 25,
            y: invalidAgeLabel.bottom + 8,
            width: view.width - 50,
            height: 48)
        
        invalidPasswordLabel.frame = CGRect(
            x: 27,
            y: passwordTextField.bottom + 2,
            width: view.width - 50,
            height: 12.0)
        
        registerButton.frame = CGRect(
            x: 25,
            y: invalidPasswordLabel.bottom + 24,
            width: view.width - 50,
            height: 48)
    }
    
    // MARK: - Setup
    private func addSubviews() {
        view.addSubview(emailTextField)
        view.addSubview(invalidEmailLabel)
        view.addSubview(ageTextField)
        view.addSubview(invalidAgeLabel)
        view.addSubview(passwordTextField)
        view.addSubview(invalidPasswordLabel)
        view.addSubview(registerButton)
    }
    
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
    
    private func configureViewModel() {
        coreDataManager = CoreDataManager()
//        viewModel = DefaultRegisterViewModel(with: coreDataManager)
    }
    
    // MARK: - Registration Validations
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
   
    private func registerUser() {
//        if viewModel.registration(email: email, age: age, password: password) == true {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoGalleryViewController") as? PhotoGalleryViewController
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
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

extension RegisterViewController: UITextFieldDelegate{
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
