//
//  PhotoGalleryViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import Combine

class PhotoGalleryViewController: UIViewController {

    private var subscriptions: Set<AnyCancellable> = []
    private let viewModel: ImagesViewModel = ImagesViewModel()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ImageViewCell.self, forCellReuseIdentifier: ImageViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        return view
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setUpTableView()
        self.view.backgroundColor = .systemBackground
    }

    func bindViewModel() {
        viewModel.$imageViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (images) in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
    }

    func setUpTableView() {
        let margins = view.safeAreaLayoutGuide
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
        
    }
}

extension PhotoGalleryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageViewModels.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.identifier, for: indexPath) as! ImageViewCell
        cell.viewModel = viewModel.imageViewModel(at: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        print("indexPath:", indexPath)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController
        vc?.imageViewModel = viewModel.imageViewModel(at: indexPath)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
