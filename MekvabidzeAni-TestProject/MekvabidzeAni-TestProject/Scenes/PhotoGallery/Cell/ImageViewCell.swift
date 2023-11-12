//
//  ImageViewCell.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/11/23.
//

import Combine
import UIKit

class ImageViewCell: UITableViewCell {
    
    static let identifier = String(describing: ImageViewCell.self)
    private var aspectConstraint: NSLayoutConstraint!
    private var subscription: Cancellable!
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var authorNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        return view
    }()

    var viewModel: ImageViewModel! {
        didSet {
            setUpViewModel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if aspectConstraint != nil {
            mainImageView.removeConstraint(aspectConstraint)
        }
        subscription.cancel()
        subscription = nil
        mainImageView.image = nil
    }
    
    private func setUp() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(authorNameLabel)

        let margins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: margins.topAnchor),

            authorNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            authorNameLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        setUpActivityIndicator()
    }
    
    private func setUpActivityIndicator() {
        mainImageView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
        ])
    }
    
    private func setUpViewModel() {
        mainImageView.accessibilityIdentifier = "MainImageView"
        authorNameLabel.text = viewModel.userName
        
        //aspect constraint
        aspectConstraint = mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: viewModel.aspectRatio)
        aspectConstraint.priority = .init(999)
        aspectConstraint.accessibilityLabel = "aspectConstraint"
        aspectConstraint.identifier = "aspectConstraint"
        aspectConstraint.isActive = true
        
        guard let imageURL = viewModel.imageURL else {
            return
        }
        // Calculate frames
        if mainImageView.bounds.size == .zero {
            mainImageView.setNeedsLayout()
            mainImageView.layoutIfNeeded()
        }
        subscription = viewModel
            .fetchImage(for: mainImageView.bounds.size)
            .filter { _ in
                return imageURL == self.viewModel.imageURL
            }
            .assertNoFailure()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] sub in
                DispatchQueue.main.async {
                    self?.activityIndicator.startAnimating()
                }
            }, receiveCompletion: { [weak self] (completion) in
                self?.activityIndicator.stopAnimating()
            })
            .assign(to: \.image, on: mainImageView)
    }
}


