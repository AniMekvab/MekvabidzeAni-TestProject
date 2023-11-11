//
//  PixabayImageRepository.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine

protocol PixabayImageRepository {
    func fetchImages(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error>
}

class PixabayImageRepositoryImp: PixabayImageRepository {
    
    private let pixabayImageServiceProtocol: PixabayImageServiceProtocol
    
    init(pixabayImageServiceProtocol: PixabayImageServiceProtocol) {
        self.pixabayImageServiceProtocol = pixabayImageServiceProtocol
    }
    
    func fetchImages(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error> {
        pixabayImageServiceProtocol.fetchImages(pageNumber: pageNumber, imagesPerPage: imagesPerPage)
    }
    
}
