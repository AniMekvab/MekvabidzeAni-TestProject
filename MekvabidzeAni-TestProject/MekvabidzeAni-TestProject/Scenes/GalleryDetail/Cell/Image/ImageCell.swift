//
//  ImageCell.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {
    
    //MARK: - Variables

    static let identifier = String(describing: ImageCell.self)
    
    // MARK: - Views

    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
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

        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: margins.topAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 200),
            mainImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    //MARK: - Setup
    
    func configure(with model: ImageCellModel) {
        mainImageView.kf.setImage(with: URL(string: model.url), placeholder: UIImage.placeholderImage)
    }
}
