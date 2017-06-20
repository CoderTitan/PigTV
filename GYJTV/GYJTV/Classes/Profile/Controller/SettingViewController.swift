//
//  SettingViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class SettingViewController: BaseProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

//MARK: 数据处理
extension SettingViewController{
    override func loadProfileData() {
        super.loadProfileData()
        // 1.第一组数据
        let section0Model = SettingSectionModel()
        section0Model.sectionHeight = 5
        
        let section0Item = SettingItemModel(icon: "", title: "开播提醒", "", .onswitch)
        section0Model.sectionArr.append(section0Item)
        let section1Item = SettingItemModel(icon: "", title: "移动流量提醒", "", .onswitch)
        section0Model.sectionArr.append(section1Item)
        let section2Item = SettingItemModel(icon: "", title: "网络环境优化", "", .onswitch)
        section0Model.sectionArr.append(section2Item)
        
        settingArrar.append(section0Model)
        
        // 2.第二组数据
        let section1Model = SettingSectionModel()
        section1Model.sectionHeight = 5
        
        let section1Item0 = SettingItemModel(icon: "", title: "绑定手机", "未绑定", .arrowDetail)
        section1Model.sectionArr.append(section1Item0)
        let section1Item1 = SettingItemModel(title: "意见反馈")
        section1Model.sectionArr.append(section1Item1)
        let section1Item2 = SettingItemModel(title: "直播公约")
        section1Model.sectionArr.append(section1Item2)
        let section1Item3 = SettingItemModel(title: "关于我们")
        section1Model.sectionArr.append(section1Item3)
        let section1Item4 = SettingItemModel(title: "我要好评")
        section1Model.sectionArr.append(section1Item4)
        
        settingArrar.append(section1Model)
        
        // 3.刷新表格
        tableView.reloadData()
    }
}
