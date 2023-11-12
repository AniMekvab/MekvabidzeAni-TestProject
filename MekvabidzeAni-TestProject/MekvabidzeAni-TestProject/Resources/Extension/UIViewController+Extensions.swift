//
//  UIViewController+Extensions.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String = "", message: String = "") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
