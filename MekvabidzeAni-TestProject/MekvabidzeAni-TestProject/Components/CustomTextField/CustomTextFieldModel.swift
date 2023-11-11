//
//  CustomTextFieldModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

struct CustomTextFieldModel {
    let placeholder: String
    let delegate: UITextFieldDelegate?
    let status: Status
    
    enum Status {
        case error(String)
        case normal
    }
}
