//
//  CourseModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class CourseModel: BaseModel {

    var name : String = ""
    var picUrl : String = ""
    var linkUrl : String = ""

    override init(dic: [String : Any]) {
        super.init(dic: dic)
        
        name = dic["name"] as? String ?? ""
        picUrl = dic["picUrl"] as? String ?? ""
        linkUrl = dic["linkUrl"] as? String ?? ""
    }
}
