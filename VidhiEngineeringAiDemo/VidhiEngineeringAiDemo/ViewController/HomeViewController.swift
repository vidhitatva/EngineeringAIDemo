//
//  HomeViewController.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Outlet
    
    @IBOutlet private weak var tableViewUserList : UITableView!
    @IBOutlet private weak var viewLoadingFooter : UIView!
    //MARK: Variable
    
    private var arrayUserList  : [Users] = []
    private var hasMore : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUIElements()
        self.getUserList()
        // Do any additional setup after loading the view.
    }
    
    func setUpUIElements() {
        self.tableViewUserList.tableFooterView = self.viewLoadingFooter
    }
    
    func getUserList(with offset : Int = 0) {
        UserController.getUserWith(offset: offset) { (hasmore, users) in
            self.arrayUserList.append(contentsOf: users)
            self.hasMore = hasmore
            self.tableViewUserList.reloadData()
            if !self.hasMore {
                self.tableViewUserList.tableFooterView = nil
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserTableCell.cell
        cell.user = self.arrayUserList[indexPath.row]
        if self.hasMore && indexPath.row == self.arrayUserList.count - 1 {
            self.getUserList(with: self.arrayUserList.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let arrayItem = self.arrayUserList[indexPath.row].items
        if arrayItem!.count % 2 == 0 {
            let height = (arrayItem!.count / 2) * Int(tableView.frame.width / 2)
            return CGFloat(height + 60)
        }else {
            let height = (arrayItem!.count / 2) * Int(tableView.frame.width / 2)
            return CGFloat(height + 60) + tableView.frame.width
        }
    }
}
