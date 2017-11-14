//
//  FocusViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kFocusCell : String = "focusCell"

class FocusViewController: UITableViewController {

    //MARK: 私有属性
    fileprivate lazy var focusVM : FocusViewModel = FocusViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        loadFocusData()
    }
}

//MARK: 界面处理
extension FocusViewController{
    fileprivate func setupViews(){
        title = "我的关注"
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tableView.register(UINib(nibName: "FocusTableCell", bundle: nil), forCellReuseIdentifier: kFocusCell)
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

//MARK: 数据处理
extension FocusViewController{
    fileprivate func loadFocusData(){
        focusVM.loadFocusData { 
            self.tableView.reloadData()
        }
    }
}

//MARK: tableView代理
extension FocusViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusVM.anchorModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kFocusCell, for: indexPath) as! FocusTableCell
        cell.anchorModel = focusVM.anchorModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissScreenListPlayView()
        let roomVC = RoomViewController()
        let anchorModel = focusVM.anchorModels[indexPath.row]
        roomVC.anchorM = anchorModel
        roomVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(roomVC, animated: true)
    }
}
