//
//  RankModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class RankModel: BaseModel {
    var isInLive : Int = 0
    var nickname : String = ""
    var avatar : String = ""

    override init(dic: [String : Any]) {
        super.init(dic: dic)
        
        isInLive = dic["isInLive"] as? Int ?? 0
        nickname = dic["nickname"] as? String ?? ""
        avatar = dic["avatar"] as? String ?? ""
    }
}
