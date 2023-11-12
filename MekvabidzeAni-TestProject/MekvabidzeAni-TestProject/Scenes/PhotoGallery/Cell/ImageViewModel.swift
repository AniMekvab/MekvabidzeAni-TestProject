//
//  ImageViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Combine
import UIKit

class ImageViewModel {
    
    //MARK: - Variables

    private let imageEntity: ImageEntity
    private let imageLoader: ImageLoader
    
    var likes: String {
        return "likes: " + "\(imageEntity.likes)"
    }
    
    var userName: String {
        return "user: " + "\(imageEntity.user) "
    }
    
    var id: String {
        return "id: " + "\(imageEntity.id) "
    }
    
    var tags: String {
        return "tags: " + "\(imageEntity.tags) "
    }
    
    var views: String {
        return "views: " + "\(imageEntity.views) "
    }
    
    var downloads: String {
        return "downloads: " + "\(imageEntity.downloads) "
    }
    
    var collections: String {
        return "collections: " + "\(imageEntity.collections) "
    }
    
    var comments: String {
        return "comments: " + "\(imageEntity.comments) "
    }
    
    var type: String {
        return "type: " + "\(imageEntity.type) "
    }
    
    var imageParameters: String {
        return "imageParameters: " + "\(imageEntity.imageWidth)" + "X" + "\(imageEntity.imageHeight) "
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
    
    //MARK: - Init

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
