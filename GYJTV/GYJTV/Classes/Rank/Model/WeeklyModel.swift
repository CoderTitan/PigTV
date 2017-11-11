//
//  WeeklyModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class WeeklyModel: BaseModel {

    var giftName : String = ""
    var giftNum : Int = 0
    var nickname : String = ""
    var giftAppImg : String = ""

    override init(dic: [String : Any]) {
        super.init(dic: dic)
        
        giftNum = dic["giftNum"] as? Int ?? 0
        giftName = dic["giftName"] as? String ?? ""
        nickname = dic["nickname"] as? String ?? ""
        giftAppImg = dic["giftAppImg"] as? String ?? ""
    }
}
