//
//  SetUpUI.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit

public class SetUpUI {
    static public func textField(placeholder: String) -> UITextField {
           
        let field =  UITextField()
        field.placeholder = placeholder
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }
    
    static public func label(text: String) -> UILabel {
        let label =  UILabel()
        label.text = text
        label.textColor = .systemRed
        label.font = label.font.withSize(12)
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }
    
    static public func button(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }
}


