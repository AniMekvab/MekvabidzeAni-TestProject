//
//  PhotoGalleryTableDataSource.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import Foundation
import UIKit

final class PhotoGalleryTableDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Variables

    private weak var tableView: UITableView?
    private weak var viewModel: ImagesViewModel?
    private weak var viewController: UIViewController?

    //MARK: - Init

    init(with tableView: UITableView, viewModel: ImagesViewModel = ImagesViewModel(), viewController: UIViewController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.viewController = viewController
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.imageViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.identifier, for: indexPath) as! ImageViewCell
        cell.viewModel = viewModel?.imageViewModel(at: indexPath)
        return cell
    }
    
}

//MARK: - Delegate

extension PhotoGalleryTableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath:", indexPath)
        let vc = PhotoDetailViewController()
        vc.imageViewModel = viewModel?.imageViewModel(at: indexPath)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
