//
//  PhotoDetailViewController.swift
//  MekvabidzeAni-TestProject
//
//  Created by Ani Mekvabidze on 11/10/23.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var photoDetailLabel: UILabel!
    
    var imageViewModel: ImageViewModel?
//    var comments = ""
//    var likes = ""
//    var downloads = ""
//    var imageURL: URL?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        var m = "\(imageViewModel?.likes)" + "\(imageViewModel?.userName)"
        photoDetailLabel.text = m
        imagee.kf.setImage(with: imageViewModel?.imageURL)

    }
    
}
