//
//  RegisterViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/9/23.
//

import Foundation

protocol RegisterViewModel: AnyObject {
    func registration(email: String, age: String, password: String) -> Bool
     
    init(with registerUseCase: RegisterUseCase)
}

final class DefaultRegisterViewModel: RegisterViewModel {
    
    private let registerUseCase: RegisterUseCase

    init(with registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }
    
    func registration(email: String, age: String, password: String) -> Bool {
        var registrationSuccess = false
        registerUseCase.register(withEmail: email, withAge: age, withPassword: password) { success in
            print("Registration is successful : \(success)")
            registrationSuccess = success
        }
        return registrationSuccess

    }
}
