//
//  CheckValidation.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

public class CheckValidation {
    static public func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static public func isValidAge(_ age: Int) -> Bool {
        lazy var validAge = false
        if age >= 18 && age <= 99 {
            validAge = true
        }
        return validAge
    }
    
    static public func isValidPassword(_ password: String) -> Bool {
        lazy var validPassword = false
        if password.count >= 6 && password.count <= 12 {
            validPassword = true
        }
        return validPassword
    }
}
