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

    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArray = value as? [[String : Any]] {
                for listDic in listArray {
                    list.append(GiftModel(dic: listDic))
                }
            }
        }else{
            super.setValue(value, forUndefinedKey: key)
        }
    }
}
