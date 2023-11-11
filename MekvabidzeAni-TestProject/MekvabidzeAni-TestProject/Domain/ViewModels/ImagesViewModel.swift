//
//  ImagesViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine

class ImagesViewModel: ObservableObject {
    @Published var inputQuery: String = "Dog"
    @Published private(set) var imageViewModels: [ImageViewModel] = []

    private var subscriptions: Set<AnyCancellable> = []
    private let imagesService: ImageServiceProtocol
    
    init(imagesService: ImageServiceProtocol = PixabayImageService()) {
        self.imagesService = imagesService
        $inputQuery
            .sink { [unowned self] (value) in
            self.fetchImages(with: value)
        }.store(in: &subscriptions)
    }
    
    private func fetchImages(with query: String) {
        let loader = KingfisherLoader()
        imagesService.queryImages(with: query, pageNumber: 1, imagesPerPage: 100).sink { (completion) in
            switch completion {
            case .finished:
                print("task has finished")
            case .failure(let error):
                print("task has finished with error: \(error)")
            }
        } receiveValue: { [weak self] (images) in
            self?.imageViewModels = images.map { ImageViewModel(imageEntity: $0, imageLoader: loader) }
        }.store(in: &subscriptions)

    }
    
    func imageViewModel(at indexPath: IndexPath) -> ImageViewModel {
        return imageViewModels[indexPath.row]
    }
}
