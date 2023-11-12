//
//  PasswordValidation.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

protocol PasswordValidation {
    func validate(_ password: String) -> PasswordValidationStatus
}

struct PasswordValidationImp: PasswordValidation {
    func validate(_ password: String) -> PasswordValidationStatus {
        if password.isEmpty {
            return .empty
        } else {
            if isValidPassword(password) {
                return .success
            } else {
                return .notValid
            }
        }
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        password.count >= 6 && password.count <= 12
    }
}

enum PasswordValidationStatus {
    case success
    case empty
    case notValid
    
    var errorMessage: String {
        switch self {
        case .empty:
            return "Password Empty"
        case .notValid:
            return "Password not valid"
        default:
            return ""
        }
    }
}
