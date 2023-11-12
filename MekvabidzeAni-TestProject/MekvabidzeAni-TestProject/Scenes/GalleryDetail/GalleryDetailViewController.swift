//
//  GalleryDetailViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit

class GalleryDetailViewController: UIViewController {
    
    //MARK: - Variables
    
    private var viewModel: GalleryDetailViewModel
    private var tableViewDataSource: GalleryDetailTableDataSource!

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        view.register(LabelCell.self, forCellReuseIdentifier: LabelCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    //MARK: - Init
    
    public init(viewModel: GalleryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


    //MARK: - LifeCycle

extension GalleryDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
}


    //MARK: - Setup

extension GalleryDetailViewController {
    private func setupAppearance() {
        title = "Detail"
        view.backgroundColor = .systemBackground
        buildSubviews()
        buildConstraints()
        tableViewDataSource = .init(with: tableView, viewModel: viewModel, viewController: self)
    }
    
    private func buildSubviews() {
        view.addSubview(tableView)
    }
    
    private func buildConstraints() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
    }
}
