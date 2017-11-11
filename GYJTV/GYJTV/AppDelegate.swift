//
//  AppDelegate.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/13.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //数据库创建对象
        setupFocusDB()
        //导航栏处理
        setnavigationBar()
        
        return true
    }
}


extension AppDelegate{
    //创建数据库对象
    fileprivate func setupFocusDB(){
        let isOpen = SqliteTools.openDB(String.documentPath + "/focus.sqlite1")
        isOpen == true ? print("数据库打开成功") : print("数据库打开失败")
        let createFocusTable = "CREATE TABLE IF NOT EXISTS t_focus ( " +
            "roomid INTEGER PRIMARY KEY, " +
            "name TEXT, " +
            "pic51 TEXT, " +
            "pic74 TEXT, " +
            "live INTEGER, " +
            "push INTEGER " +
        ");"
        let isCreate = SqliteTools.excuteSqlite(createFocusTable)
        isCreate == true ? print("数据库创建成功") : print("数据库创建失败")
    }
    
    fileprivate func setnavigationBar(){
        //设置导航栏背景为黑色,字体为白色
        let naviBar = UINavigationBar.appearance()
        naviBar.barTintColor = UIColor.black
        naviBar.tintColor = UIColor.white
        naviBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        //设置状态栏及导航栏底部为透明的,默认为true
        let tabbar = UITabBar.appearance()
        tabbar.isTranslucent = true
        
        //设置tableVIew的section的头,尾标题为橙色,字体为14
        let header = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
        header.textColor = UIColor.orange
        header.font = UIFont.systemFont(ofSize: 14)
    }
}
