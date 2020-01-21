//
//  HeaderCollectionReusableView.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 21/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
   
    @IBOutlet private weak var imageViewUser: UIImageView!
    @IBOutlet private weak var labelUser: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var user : Users! {
        didSet {
            self.labelUser.text =  self.user.name
            self.imageViewUser.sd_setImage(with: URL(string:  self.user.image!)) { (image, error, type, url) in
            }
        }
    }
    
}
