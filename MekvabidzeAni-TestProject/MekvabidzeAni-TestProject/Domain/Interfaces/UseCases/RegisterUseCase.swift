//
//  RegisterUseCase.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

protocol RegisterUseCase {
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void))
}

class RegisterUseCaseImp: RegisterUseCase {
    private let repository: AuthorizationRepository
    
    init(repository: AuthorizationRepository) {
        self.repository = repository
    }
    
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void)) {
        repository.register(withEmail: email, withAge: age, withPassword: password, completion: completion)
    }
}
