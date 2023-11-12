//
//  AgeValidation.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

protocol AgeValidation {
    func validate(_ age: String) -> AgeValidationStatus
}

struct AgeValidationImp: AgeValidation {
    func validate(_ age: String) -> AgeValidationStatus {
        if age.isEmpty {
            return .empty
        } else {
            if isValidAge(age.toInt) {
                return .success
            } else {
                return .notValid
            }
        }
    }
    
    private func isValidAge(_ age: Int) -> Bool {
        age >= 18 && age <= 99
    }
}

enum AgeValidationStatus {
    case success
    case empty
    case notValid
    
    var errorMessage: String {
        switch self {
        case .empty:
            return "Age Empty"
        case .notValid:
            return "Age not valid"
        default:
            return ""
        }
    }
}
