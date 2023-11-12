//
//  GalleryCell.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit
import Kingfisher

class GalleryCell: UITableViewCell {
    
    //MARK: - Variables

    static let identifier = String(describing: GalleryCell.self)
    
    // MARK: - Views

    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var authorNameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(authorNameLabel)

        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: margins.topAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 200),

            authorNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12),
            authorNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    //MARK: - Setup
    
    func configure(with model: GalleryCellModel) {
        authorNameLabel.text = model.label
        mainImageView.kf.setImage(with: URL(string: model.url), placeholder: UIImage.placeholderImage)
    }
}
