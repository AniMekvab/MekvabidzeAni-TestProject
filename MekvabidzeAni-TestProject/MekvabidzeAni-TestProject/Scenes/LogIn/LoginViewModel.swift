//
//  LoginViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
    
    init(with coreDataManager: CoreDataManagerProtocol)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(with coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func login(email: String, password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        coreDataManager.login(with: email, with: password, completion: completion)
    }
    
}
