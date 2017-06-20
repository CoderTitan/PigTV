//
//  SettingItemModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

//MARK: 右侧显示样式
enum  SettingAccessoryType {
    case none          //什么都没有
    case arrow         //右侧箭头
    case arrowDetail   //右侧箭头,详情文字
    case detail        //右侧文字
    case onswitch      //开关
}

class SettingItemModel {

    var iconImage : String = ""   //左侧图片
    var titleText : String = ""   //左侧文字
    var detailText : String = ""  //右侧文字
    var type : SettingAccessoryType = .arrow
    
    //初始化方法
    init(icon : String = "", title : String, _ detail : String = "", _ type : SettingAccessoryType = .arrow) {
        self.iconImage = icon
        self.titleText = title
        self.detailText = detail
        self.type = type
    }
    
}
