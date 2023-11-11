//
//  LoginUseCase.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

protocol LoginUseCase {
    func execute(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
}

class LoginUseCaseImp: LoginUseCase {
    private let repository: AuthorizationRepository
    
    init(repository: AuthorizationRepository) {
        self.repository = repository
    }
    
    func execute(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        repository.login(with: email, with: password, completion: completion)
    }
}
