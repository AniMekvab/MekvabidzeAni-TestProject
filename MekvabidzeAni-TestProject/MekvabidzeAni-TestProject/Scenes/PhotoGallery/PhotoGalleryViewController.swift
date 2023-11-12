//
//  PhotoGalleryViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import Combine

class PhotoGalleryViewController: UIViewController {
    
    //MARK: - Variables

    private var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ImagesViewModel
    private var tableViewDataSource: PhotoGalleryTableDataSource!

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ImageViewCell.self, forCellReuseIdentifier: ImageViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        return view
        
    }()
    
    //MARK: - Init
    
    public init(viewModel: ImagesViewModel = ImagesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        viewModel.$imageViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (images) in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
}


//MARK: - LifeCycle

extension PhotoGalleryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setUpTableView()
        self.view.backgroundColor = .systemBackground
    }
}


//MARK: - Setup

extension PhotoGalleryViewController {
    private func setUpTableView() {
        let margins = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
        
        tableViewDataSource = .init(with: tableView, viewModel: viewModel, viewController: self)
    }
    
}
