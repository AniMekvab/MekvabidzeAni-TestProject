//
//  GalleryDetailTableDataSource.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/12/23.
//

import Foundation
import UIKit

final class GalleryDetailTableDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Variables

    private weak var tableView: UITableView?
    private weak var viewModel: GalleryDetailViewModel?
    private weak var viewController: UIViewController?

    //MARK: - Init

    init(with tableView: UITableView, viewModel: GalleryDetailViewModel, viewController: UIViewController) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.viewController = viewController
        super.init()
        self.tableView?.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.photoDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.photoDetails[section].count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = viewModel?.photoDetails[indexPath.section][indexPath.row] as? LabelCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier) as! LabelCell
            cell.configure(with: model)
            return cell
        } else if let model = viewModel?.photoDetails[indexPath.section][indexPath.row] as? ImageCellModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier) as! ImageCell
            cell.configure(with: model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ["SECTION: ", (section + 1).toString].joined()
    }
}
