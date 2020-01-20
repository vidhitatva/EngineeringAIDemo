//
//  UserTableCell.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableCell: UITableViewCell {

    @IBOutlet private weak var imageViewUser: UIImageView!
    @IBOutlet private weak var labelUser: UILabel!
    @IBOutlet private weak var collectionViewImageItem: UICollectionView!
    
    private var arrayItem : [String] = []
    
    static var cell : UserTableCell {
        return UINib(nibName: "UserTableCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UserTableCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewImageItem.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
        self.collectionViewImageItem.dataSource = self
        self.collectionViewImageItem.delegate = self
        
        // Initialization code
    }
    
    var user : Users! {
        didSet {
            self.labelUser.text =  self.user.name
            self.imageViewUser.sd_setImage(with: URL(string:  self.user.image!)) { (image, error, type, url) in
            self.arrayItem = self.user.items ?? []
            self.collectionViewImageItem.reloadData()
          }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UserTableCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cell.imageStr = self.arrayItem[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.arrayItem.count % 2 == 0 {
            let width = collectionView.frame.size.width/2 - 5
            return CGSize(width: width, height: width)
        }else {
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
            }else {
                let width = collectionView.frame.size.width/2 - 5
                return CGSize(width: width, height: width)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

}
