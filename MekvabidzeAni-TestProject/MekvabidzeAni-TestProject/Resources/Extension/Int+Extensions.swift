//
//  Int+Extensions.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

extension Swift.Optional where Wrapped == Int {
    var notNil: Int {
        self ?? 0
    }
}
