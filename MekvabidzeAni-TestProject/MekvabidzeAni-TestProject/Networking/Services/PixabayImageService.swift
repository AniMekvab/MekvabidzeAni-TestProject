//
//  PixabayImageService.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine

protocol PixabayImageServiceProtocol {
    func fetchImages(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error>
}

class PixabayImageService: PixabayImageServiceProtocol {
    func fetchImages(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error> {
        
        var components = URLComponents(string: "https://pixabay.com/api")!
        components.queryItems = [
            .init(name: "key", value: "40548542-cda5c7ce6935f2bbed99b765b"),
            .init(name: "image_type", value: "photo"),
            .init(name: "per_page", value: "\(imagesPerPage)"),
            .init(name: "page", value: "\(pageNumber)"),
        ]
        
        let request = URLRequest(url: components.url!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ServerResponse.self, decoder: JSONDecoder())
            .map { $0.hits }
            .eraseToAnyPublisher()
    }
}
