//
//  BaseModel.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    override init(){
        
    }
    init(dic : [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
