//
//  ImageServiceProtocol.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Combine

protocol ImageServiceProtocol {
    func queryImages(with query: String, pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error>
}
