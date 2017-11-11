//
//  ProfileViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kHeaderViewHeight : CGFloat = 200
class ProfileViewController: BaseProfileViewController {

    //MARK: 懒加载
    fileprivate lazy var headerView : ProfileHeaderView = ProfileHeaderView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func setupTableView() {
        super.setupTableView()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kHeaderViewHeight)
        tableView.tableHeaderView = headerView
    }

    
    override func loadProfileData() {
        super.loadProfileData()
        
        // 1.第一组数据
        let section0Model = SettingSectionModel()
        section0Model.sectionHeight = 5
        
        let section0Item = SettingItemModel(icon: "mine_follow", title: "我的关注", "30人", .detail)
        section0Model.sectionArr.append(section0Item)
        let section1Item = SettingItemModel(icon: "mine_money", title: "我的帆币")
        section0Model.sectionArr.append(section1Item)
        let section2Item = SettingItemModel(icon: "mine_fanbao", title: "我的帆宝", "点击查看", .arrowDetail)
        section0Model.sectionArr.append(section2Item)
        let section3Item = SettingItemModel(icon: "mine_bag", title: "我的背包", "查看礼物", .arrowDetail)
        section0Model.sectionArr.append(section3Item)
        let section4Item = SettingItemModel(icon: "mine_money", title: "现金红包")
        section0Model.sectionArr.append(section4Item)
        
        settingArrar.append(section0Model)
        
        // 2.第二组数据
        let section1Model = SettingSectionModel()
        section1Model.sectionHeight = 5
        
        let section1Item0 = SettingItemModel(icon: "mine_edit", title: "编辑资料")
        section1Model.sectionArr.append(section1Item0)
        let section1Item1 = SettingItemModel(icon: "mine_set", title: "设置")
        section1Model.sectionArr.append(section1Item1)
        
        settingArrar.append(section1Model)
        
        // 3.刷新表格
        tableView.reloadData()
    }
}

//MARK: 代理
extension ProfileViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if indexPath.section == 1 && indexPath.row == 1 {
            navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }
}
