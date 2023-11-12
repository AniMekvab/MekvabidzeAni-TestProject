//
//  GalleryViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import Foundation
import Combine

class GalleryViewModel {
    var photoCellModels: [GalleryCellModel] = []
    var imageEntities: [ImageEntity] = []
    var pageNumber: Int { 1 }
    var imagesPerPage: Int { 50 }
    private let pixabayImageUseCase: PixabayImageUseCase
    private var reloadTableView: PassthroughSubject<Bool, Never> = .init()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(pixabayImageUseCase: PixabayImageUseCase = PixabayImageUseCaseImp(
        repository: PixabayImageRepositoryImp(
            pixabayImageServiceProtocol: PixabayImageService()))) {
        self.pixabayImageUseCase = pixabayImageUseCase
    }
    
    func onLoad() {
        fetchImages()
    }
    
    func fetchImages() {
        pixabayImageUseCase.execute(pageNumber: pageNumber,
                                    imagesPerPage: imagesPerPage)
        .sink { completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
            default:
                break
            }
        } receiveValue: { [weak self] imageEntities in
            self?.didReceiveImages(imageEntities)
        }.store(in: &subscriptions)
    }
    
    func didReceiveImages(_ images: [ImageEntity]) {
        imageEntities = images
        photoCellModels = images.map(mapToPhotoCellModels)
        reloadTableView.send(true)
    }
    
    private func mapToPhotoCellModels(_ imageEntity: ImageEntity) -> GalleryCellModel {
        .init(url: imageEntity.largeImageURL,
              label: imageEntity.user)
    }
    
    var getReloadTableView: AnyPublisher<Bool, Never> {
        reloadTableView
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
