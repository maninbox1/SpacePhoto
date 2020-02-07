//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Mikhail Ladutska on 1/29/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let photoInfoController = PhotoInfoController()
    
    
    //MARK: outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var newLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.layer.cornerRadius = 4.0
        
        newLabel.text = ""
        copyrightLabel.text = ""
        
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else {return}
        
        let task = URLSession.shared.dataTask(with: url,
        completionHandler: { (data, response, error) in
    
            guard let data = data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.imageView.image = image
                self.newLabel.text =
                    photoInfo.description
    
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text =
                    "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        })
    
        task.resume()
    }
    

}

