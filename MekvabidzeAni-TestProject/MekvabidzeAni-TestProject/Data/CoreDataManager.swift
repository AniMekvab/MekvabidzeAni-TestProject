//
//  CoreDataManager.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import CoreData

enum AuthorizationError: Error {
    case userNotFound
    case unknownError
}

protocol CoreDataManagerProtocol: AnyObject {
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void))
    func login(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void))
    
    var context: NSManagedObjectContext? { get }
}

extension CoreDataManagerProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    func register(withEmail email: String, withAge age: String, withPassword password: String, completion: @escaping ((Bool) -> Void)) {
        
        guard let context = context else { return }
        let user = User(context: context)
        user.email = email
        user.age = age
        user.password = password
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func login(with email: String, with password: String, completion: @escaping ((Result<User?, AuthorizationError>) -> Void)) {
        guard let context = context else { return }
        
        do {
            let predicate = NSPredicate(format: "email = %@ AND password = %@", email, password)
            let request = NSFetchRequest<User>(entityName: "User")
            request.predicate = predicate
            
            let users = try context.fetch(request)
            
            if let last = users.last {
                completion(.success(last))
            } else {
                completion(.failure(.userNotFound))
            }
            
        } catch {
            completion(.failure(.unknownError))
        }
        
    }
    
}
