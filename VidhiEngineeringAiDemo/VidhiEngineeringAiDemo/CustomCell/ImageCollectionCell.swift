//
//  ImageCollectionCell.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageViewUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var imageStr : String? {
        didSet {
            self.imageViewUser.sd_setImage(with: URL(string: imageStr!)) { (image, error, type, url) in
            }
        }
    }
}
