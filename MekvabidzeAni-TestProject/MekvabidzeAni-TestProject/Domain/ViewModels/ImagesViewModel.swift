//
//  ImagesViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine

class ImagesViewModel: ObservableObject {
    @Published var input: String = ""
    @Published private(set) var imageViewModels: [ImageViewModel] = []

    private var subscriptions: Set<AnyCancellable> = []
    private let pixabayImageUseCase: PixabayImageUseCase
    
    init(pixabayImageUseCase: PixabayImageUseCase = PixabayImageUseCaseImp(
        repository: PixabayImageRepositoryImp(
            pixabayImageServiceProtocol: PixabayImageService()))) {
        self.pixabayImageUseCase = pixabayImageUseCase
        $input
            .sink { [unowned self] (value) in
            self.fetchPixabayImages()
        }.store(in: &subscriptions)
    }
    
    private func fetchPixabayImages() {
        let loader = KingfisherLoader()
        pixabayImageUseCase.execute(pageNumber: 1, imagesPerPage: 100).sink { (completion) in
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
