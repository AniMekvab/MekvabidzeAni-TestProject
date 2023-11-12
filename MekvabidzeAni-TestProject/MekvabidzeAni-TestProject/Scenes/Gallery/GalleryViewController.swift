//
//  GalleryViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import UIKit
import Combine

class GalleryViewController: UIViewController {
    
    //MARK: - Variables

    private var subscriptions: Set<AnyCancellable> = []
    private var viewModel: GalleryViewModel
    private var tableViewDataSource: GalleryTableDataSource!

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(GalleryCell.self, forCellReuseIdentifier: GalleryCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    
    public init(viewModel: GalleryViewModel = GalleryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


    //MARK: - LifeCycle

extension GalleryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        bindViewModel()
        viewModel.onLoad()
    }
}


    //MARK: - Setup

extension GalleryViewController {
    private func setupAppearance() {
        title = "Gallery"
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

  //MARK: - Navigation
extension GalleryViewController {
    func toGalleryDetail(with model: ImageEntity) {
        let vc = GalleryDetailViewController(viewModel: GalleryDetailViewModel.init(imageEntity: model))
        navigationController?.pushViewController(vc, animated: true)
    }
}


    //MARK: - Bind

extension GalleryViewController {
    private func bindViewModel() {
        viewModel.getReloadTableView
            .sink { [weak self] bool in
                if bool {
                    self?.tableView.reloadData()
                }
            }.store(in: &subscriptions)
    }
}
