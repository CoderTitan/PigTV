//
//  HomeViewController.swift
//  XMGTV
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        setupUI()
    }
    
}


// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        // 1.左侧logoItem
        let logoImage = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        // 2.设置右侧收藏的item
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(followItemClick))
        // 事件监听 --> 发送消息 --> 将方法包装SEL  --> 类方法列表 --> IMP)
        // 3.搜索框
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .minimal
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.white
    }
}

// MARK:- 事件监听函数
extension HomeViewController {
    @objc fileprivate func followItemClick() {
        print("------")
    }
}

