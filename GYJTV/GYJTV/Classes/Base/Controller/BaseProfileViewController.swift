//
//  BaseProfileViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kProfileCell : String = "profile"
private let kTableRowHeight : CGFloat = 55

class BaseProfileViewController: UIViewController {

    //MARK: 对外属性
    lazy var tableView : UITableView = UITableView()
    lazy var settingArrar : [SettingSectionModel] = [SettingSectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadProfileData()
    }
    
    ///界面处理
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = kTableRowHeight
        tableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: kProfileCell)
    }
    
    /// 数据处理
    func loadProfileData() {
        
    }
}


//MARK: UITableViewDataSource, UITableViewDelegate
extension BaseProfileViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingArrar.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArrar[section].sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kProfileCell, for: indexPath) as! ProfileViewCell
        cell.settingModel = settingArrar[indexPath.section].sectionArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return settingArrar[section].sectionHeight
    }
}
