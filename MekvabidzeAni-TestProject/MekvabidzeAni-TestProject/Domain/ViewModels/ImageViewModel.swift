//
//  ImageViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Combine
import UIKit

class ImageViewModel {
    private let imageEntity: ImageEntity
    private let imageLoader: ImageLoader
    
    var likes: String {
        return "likes:" + "\(imageEntity.likes)"
    }
    
    var userName: String {
        return "user:" + "\(imageEntity.user) "
    }
    
    var imageSize: CGSize {
        return .init(width: imageEntity.imageWidth, height: imageEntity.imageHeight)
    }
    
    var aspectRatio: CGFloat {
        return imageSize.height / imageSize.width
    }
    
    var imageURL: URL? {
        return URL(string: imageEntity.largeImageURL)
    }
    
    init(imageEntity: ImageEntity, imageLoader: ImageLoader) {
        self.imageEntity = imageEntity
        self.imageLoader = imageLoader
    }
    
    func fetchImage(for size: CGSize) -> AnyPublisher<UIImage?, ImageLoaderError> {
        guard let url = imageURL else {
            return Combine.Empty().eraseToAnyPublisher()
    }
        return imageLoader.loadImage(with: url, for: size)
            .eraseToAnyPublisher()
    }
    
    
}
