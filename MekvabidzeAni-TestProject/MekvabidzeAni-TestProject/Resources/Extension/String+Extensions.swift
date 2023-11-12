//
//  String+Extensions.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

extension Swift.Optional where Wrapped == String {
    var notNil: String {
        self ?? ""
    }
}

extension String {
    var toInt: Int {
        Int(self) ?? 0
    }
}
