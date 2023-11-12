//
//  GalleryTableDataSource.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import Foundation
import UIKit

final class GalleryTableDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Variables

    private weak var tableView: UITableView?
    private weak var viewModel: GalleryViewModel?
    private weak var viewController: GalleryViewController?

    //MARK: - Init

    init(with tableView: UITableView, viewModel: GalleryViewModel, viewController: GalleryViewController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.viewController = viewController
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.photoCellModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        guard let model = viewModel?.photoCellModels[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
}

//MARK: - Delegate

extension GalleryTableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.imageEntities[indexPath.row] else { return }
        viewController?.toGalleryDetail(with: model)
    }
}
