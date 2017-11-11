//
//  HomeType.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class HomeType: BaseModel {

    var title : String = ""
    var type : Int = 0
    
    override init(dic : [String : Any]) {
        super.init()
        
        title = dic["title"] as? String ?? ""
        type = dic["type"] as? Int ?? 0
    }
}
