//
//  PixabayImageRepository.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine

protocol PixabayImageRepository {
    func queryImages(with query: String, pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error>
}

class PixabayImageRepositoryImp: PixabayImageRepository {
    
    private let pixabayImageServiceProtocol: PixabayImageServiceProtocol
    
    init(pixabayImageServiceProtocol: PixabayImageServiceProtocol) {
        self.pixabayImageServiceProtocol = pixabayImageServiceProtocol
    }
    
    func queryImages(with query: String, pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error> {
        pixabayImageServiceProtocol.queryImages(with: query, pageNumber: pageNumber, imagesPerPage: imagesPerPage)
    }
    
}
