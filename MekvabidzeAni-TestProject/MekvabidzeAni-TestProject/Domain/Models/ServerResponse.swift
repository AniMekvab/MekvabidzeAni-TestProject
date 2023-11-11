//
//  ServerResponse.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation

struct ServerResponse: Decodable {
    let hits: [ImageEntity]
}
