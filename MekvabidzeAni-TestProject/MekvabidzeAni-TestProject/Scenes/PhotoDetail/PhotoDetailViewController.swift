//
//  PhotoDetailViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import Kingfisher

class ImageSection {
   var sectionName: String?
   var modelName: [String]?
     
   init(sectionName: String, modelName: [String]) {
       self.sectionName = sectionName
       self.modelName = modelName
   }
}

class PhotoDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
 
    var imageSection = [ImageSection]()
    var imageViewModel: ImageViewModel?
       
    // MARK: - Views

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(PhotoDetailTableViewCell.self, forCellReuseIdentifier: PhotoDetailTableViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
        return view
        
    }()

       override func viewDidLoad() {
           super.viewDidLoad()

           setUpTableView()
           self.view.backgroundColor = .systemBackground

           imageSection.append(ImageSection.init(sectionName: "Section 1", modelName: ["\(imageViewModel?.imageParameters ?? "")", "\(imageViewModel?.type ?? "")", "\(imageViewModel?.tags ?? "")"]))
              
           imageSection.append(ImageSection.init(sectionName: "Section 2", modelName: ["\(imageViewModel?.userName ?? "")" + "\(imageViewModel?.id ?? "")", "\(imageViewModel?.views ?? "")", "\(imageViewModel?.likes ?? "")",  "\(imageViewModel?.comments ?? "")",  "\(imageViewModel?.collections ?? "")",  "\(imageViewModel?.downloads ?? "")"]))
       }

    private func setUpTableView() {
        let margins = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
        ])
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return imageSection.count
    }
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .systemBackground
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = imageSection[section].sectionName
        view.addSubview(lbl)
        return view
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageSection[section].modelName?.count ?? 0
    }
         
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDetailTableViewCell.identifier, for: indexPath)
           cell.textLabel?.text = imageSection[indexPath.section].modelName?[indexPath.row]
           return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 40
    }

}
