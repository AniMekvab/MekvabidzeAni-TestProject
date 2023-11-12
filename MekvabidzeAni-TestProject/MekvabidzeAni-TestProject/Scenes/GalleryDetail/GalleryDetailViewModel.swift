//
//  GalleryDetailViewModel.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

class GalleryDetailViewModel {
    var photoDetails: [[Any]]
    
    init(photoDetails: [[Any]]) {
        self.photoDetails = photoDetails
    }
    
    convenience init(imageEntity: ImageEntity) {
        self.init(photoDetails: GalleryDetailViewModel.mapToPhotoDetails(imageEntity))
    }

    static func mapToPhotoDetails(_ imageEntity: ImageEntity) -> [[Any]] {
        [
            [
                ImageCellModel(url: imageEntity.largeImageURL),
                LabelCellModel(label: ["size: ", imageEntity.imageSize.toString].joined()),
                LabelCellModel(label: ["type: ", imageEntity.type].joined()),
                LabelCellModel(label: ["tags: ", imageEntity.tags].joined())
            ],
            [
                LabelCellModel(label: ["photo author: ", imageEntity.user].joined()),
                LabelCellModel(label: ["views count: ", imageEntity.views.toString].joined()),
                LabelCellModel(label: ["likes count: ", imageEntity.likes.toString].joined()),
                LabelCellModel(label: ["comments count: ", imageEntity.comments.toString].joined()),
                LabelCellModel(label: ["favourite add count: ", imageEntity.collections.toString].joined()),
                LabelCellModel(label: ["downloads count: ", imageEntity.downloads.toString].joined()),
            ]
        ]
    }
}
