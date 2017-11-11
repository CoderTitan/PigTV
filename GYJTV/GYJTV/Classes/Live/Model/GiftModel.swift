//
//  GiftModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class GiftModel: BaseModel {
    var img2 : String = "" // 图片url
    var coin : Int = 0 // 价格
    var subject : String = "" { // 礼物名称
        didSet{
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
    
    override init(dic : [String : Any]) {
        super.init()
        
        img2 = dic["img2"] as? String ?? ""
        coin = dic["coin"] as? Int ?? 0
        subject = dic["subject"] as? String ?? ""
    }
}
