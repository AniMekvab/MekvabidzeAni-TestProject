//
//  ImageLoader.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Foundation
import Combine
import Kingfisher
import UIKit

protocol ImageLoader {
    func loadImage(with url: URL, for size: CGSize) -> AnyPublisher<UIImage?, ImageLoaderError>
}

enum ImageLoaderError: Error {
    case loaderError(URLError)
    case unknown(Error)
}

class KingfisherLoader: ImageLoader {
    func loadImage(with url: URL, for size: CGSize) -> AnyPublisher<UIImage?, ImageLoaderError> {
        let processor = DownsamplingImageProcessor(size: size)
        return Future<UIImage?, ImageLoaderError> { (promise) in
            KingfisherManager.shared.retrieveImage(with: url, options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let result):
                    promise(.success(result.image))
                case .failure(let error):
                    promise(.failure(.unknown(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
