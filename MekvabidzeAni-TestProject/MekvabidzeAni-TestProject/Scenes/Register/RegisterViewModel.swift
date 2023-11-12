//
//  RegisterViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/9/23.
//

import UIKit

protocol RegisterViewModel: AnyObject {
    func register(email: String, age: String, password: String, completion: @escaping ((Bool) -> Void))
    func validateEmail(_ email: String) -> EmailValidationStatus
    func validateAge(_ age: String) -> AgeValidationStatus
    func validatePassword(_ password: String) -> PasswordValidationStatus
}

final class DefaultRegisterViewModel: RegisterViewModel {
    
    private let registerUseCase: RegisterUseCase
    private let emailValidation: EmailValidation
    private let ageValidation: AgeValidation
    private let passwordValidation: PasswordValidation

    init(registerUseCase: RegisterUseCase,
         emailValidation: EmailValidation = EmailValidationImp(),
         ageValidation: AgeValidation = AgeValidationImp(),
         passwordValidation: PasswordValidation = PasswordValidationImp()) {
        self.registerUseCase = registerUseCase
        self.emailValidation = emailValidation
        self.ageValidation = ageValidation
        self.passwordValidation = passwordValidation
    }
    
    func register(email: String, age: String, password: String, completion: @escaping ((Bool) -> Void)) {
        registerUseCase.execute(withEmail: email, withAge: age, withPassword: password, completion: completion)
    }
    
    func validateEmail(_ email: String) -> EmailValidationStatus {
        emailValidation.validate(email)
    }
    
    func validateAge(_ age: String) -> AgeValidationStatus {
        ageValidation.validate(age)
    }
    
    func validatePassword(_ password: String) -> PasswordValidationStatus {
        passwordValidation.validate(password)
    }
}
