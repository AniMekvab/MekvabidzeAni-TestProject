//
//  LoginViewModelREF.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import Foundation

protocol LoginViewModel: AnyObject {
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
    func validateEmail(_ email: String) -> EmailValidationStatus
    func validatePassword(_ password: String) -> PasswordValidationStatus
}

final class DefaultLoginViewModel: LoginViewModel {
    private let loginUseCase: LoginUseCase
    private let emailValidation: EmailValidation
    private let passwordValidation: PasswordValidation
    
    init(loginUseCase: LoginUseCase,
         emailValidation: EmailValidation = EmailValidationImp(),
         passwordValidation: PasswordValidation = PasswordValidationImp()) {
        self.loginUseCase = loginUseCase
        self.emailValidation = emailValidation
        self.passwordValidation = passwordValidation
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        loginUseCase.execute(with: email, with: password, completion: completion)
    }
    
    func validateEmail(_ email: String) -> EmailValidationStatus {
        emailValidation.validate(email)
    }
    
    func validatePassword(_ password: String) -> PasswordValidationStatus {
        passwordValidation.validate(password)
    }
}
