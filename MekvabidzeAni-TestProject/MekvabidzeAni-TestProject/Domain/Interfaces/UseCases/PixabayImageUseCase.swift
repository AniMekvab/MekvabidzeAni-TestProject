//
//  PixabayImageUseCase.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Combine

protocol PixabayImageUseCase {
    func execute(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error>
}

class PixabayImageUseCaseImp: PixabayImageUseCase {
    
    private let repository: PixabayImageRepository
    
    init(repository: PixabayImageRepository) {
        self.repository = repository
    }
    
    func execute(pageNumber: Int, imagesPerPage: Int) -> AnyPublisher<[ImageEntity], Error> {
        repository.fetchImages(pageNumber: pageNumber, imagesPerPage: imagesPerPage)
    }
    
}
