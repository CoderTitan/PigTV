//
//  GiftPackages.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class GiftPackages: BaseModel {

    var t : Int = 0
    var title : String = ""
    var list : [GiftModel] = [GiftModel]()
    
    override init(dic : [String : Any]) {
        super.init()
        
        title = dic["title"] as? String ?? ""
        t = dic["t"] as? Int ?? 0
        if let dicArr = dic["list"] as? [[String: Any]] {
            list = dicArr.map({ GiftModel(dic: $0) })
        }
    }
}
