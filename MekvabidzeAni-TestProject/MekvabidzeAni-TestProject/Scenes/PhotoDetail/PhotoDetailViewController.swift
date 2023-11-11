//
//  PhotoDetailViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var photoDetailLabel: UILabel!
    
    var imageViewModel: ImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let labelText = "\(imageViewModel?.likes ?? "")\n" + "\(imageViewModel?.userName ?? "")\n" + "\(imageViewModel?.id ?? "")\n" + "\(imageViewModel?.tags ?? "")\n" + "\(imageViewModel?.views ?? "")\n" + "\(imageViewModel?.downloads ?? "")\n" + "\(imageViewModel?.collections ?? "")\n" + "\(imageViewModel?.comments ?? "")\n" + "\(imageViewModel?.type ?? "")\n" + "\(imageViewModel?.imageParameters ?? "")\n"
        
        photoDetailLabel.text = labelText
        image.kf.setImage(with: imageViewModel?.imageURL)

    }
    
}
