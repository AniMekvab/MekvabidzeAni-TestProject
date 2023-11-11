//
//  LoginViewModelREF.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import Foundation

protocol LoginViewModelREF: AnyObject {
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
    init(with loginUseCase: LoginUseCase)
}

final class DefaultLoginViewModelREFImp: LoginViewModelREF {
    
    private let loginUseCase: LoginUseCase
    
    init(with loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        loginUseCase.login(with: email, with: password, completion: completion)
    }
    
}
