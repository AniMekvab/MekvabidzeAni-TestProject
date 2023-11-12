//
//  EmailValidation.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit

protocol EmailValidation {
    func validate(_ email: String) -> EmailValidationStatus
}

struct EmailValidationImp: EmailValidation {
    func validate(_ email: String) -> EmailValidationStatus {
        if email.isEmpty {
            return .empty
        } else {
            if isValidEmail(email) {
                return .success
            } else {
                return .notValid
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

enum EmailValidationStatus {
    case success
    case empty
    case notValid
    
    var errorMessage: String {
        switch self {
        case .empty:
            return "Email Empty"
        case .notValid:
            return "Email not valid"
        default:
            return ""
        }
    }
}
