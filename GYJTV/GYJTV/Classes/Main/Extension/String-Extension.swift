//
//  String-Extension.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import Foundation
extension String{
    static var documentPath : String{
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
}
