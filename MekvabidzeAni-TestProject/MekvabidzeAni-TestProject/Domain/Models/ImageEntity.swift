//
//  ImageEntity.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

struct ImageEntity: Decodable {
    let id: Int
    let type: String
    let tags: String
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
    let user: String
}
