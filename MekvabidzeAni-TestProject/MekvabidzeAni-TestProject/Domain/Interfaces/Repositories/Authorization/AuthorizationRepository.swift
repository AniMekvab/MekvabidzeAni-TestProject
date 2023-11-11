//
//  AuthorizationRepository.swift
//  MekvabidzeAni-TestProject
//
//  Created by  Ani Mekvabidze on 11/11/23.
//

protocol AuthorizationRepository {
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void))
    func login(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
}

class AuthorizationRepositoryImp: AuthorizationRepository {
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void)) {
        coreDataManager.register(withEmail: email, withAge: age, withPassword: password, completion: completion)
    }
    
    func login(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        coreDataManager.login(with: email, with: password, completion: completion)
    }
}
