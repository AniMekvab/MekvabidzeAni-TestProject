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
//
//protocol RegisterViewModelProtocol: AnyObject {
//    func registration(email: String, age: String, password: String) -> Bool
//
//    init(with coreDataManager: CoreDataManagerProtocol)
//}
//
//final class RegisterViewModel: RegisterViewModelProtocol {
//
//    private let coreDataManager: CoreDataManagerProtocol
//
//    init(with coreDataManager: CoreDataManagerProtocol) {
//        self.coreDataManager = coreDataManager
//    }
//
//    func registration(email: String, age: String, password: String) -> Bool {
//        var registrationSuccess = false
//        coreDataManager.register(withEmail: email, withAge: age, withPassword: password) { success in
//            print("Registration is successful : \(success)")
//            registrationSuccess = success
//        }
//        return registrationSuccess
//
//    }
//}
