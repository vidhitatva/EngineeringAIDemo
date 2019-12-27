//
//  HomeViewController.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class HomeViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet private weak var collectionViewUserList: UICollectionView!
   
    //MARK: Variable
    private var arrayUserList  : [Users] = []
    private var hasMore : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.getUserList()
        // Do any additional setup after loading the view.
    }
    
    func prepareView() {
        self.collectionViewUserList.addInfiniteScroll { (collection) in
            collection.finishInfiniteScroll()
            if self.hasMore{
                self.getUserList(with: self.arrayUserList.count)
            }
        }
    }
    func getUserList(with offset : Int = 0) {
        UserController.getUserWith(offset: offset) { (hasmore, users) in
            self.arrayUserList.append(contentsOf: users)
            self.hasMore = hasmore
            self.collectionViewUserList.reloadData()
            if !self.hasMore {
                self.collectionViewUserList.removeInfiniteScroll()
            }
        }
    }
}

extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.arrayUserList.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "HeaderCollectionReusableView",
                    for: indexPath) as? HeaderCollectionReusableView
                else {
                    fatalError("Invalid view type")
            }
            headerView.user = self.arrayUserList[indexPath.section]
            return headerView
        case  UICollectionView.elementKindSectionFooter:
            let viewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterCollectionReusableView", for: indexPath)
            return viewFooter
        default:
            assert(false, "Invalid element type")
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = self.arrayUserList[section].items {
            return items.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cell.imageStr = self.arrayUserList[indexPath.section].items?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.arrayUserList[indexPath.section].items!.count % 2 == 0 {
            let width = (collectionView.frame.size.width - 20)/2 - 5
            return CGSize(width: width, height: width)
        }else {
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.width - 20)
            }else {
                let width = (collectionView.frame.size.width - 20)/2 - 5
                return CGSize(width: width, height: width)
            }
        }
    }
}

