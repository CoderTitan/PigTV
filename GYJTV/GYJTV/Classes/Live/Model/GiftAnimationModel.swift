//
//  GiftAnimationModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/8.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class GiftAnimationModel: NSObject {

    var senderName : String = "" //送礼物者
    var senderUrl : String = ""  //
    var giftName : String = ""   //礼物名称
    var giftUrl : String = ""
    
    init(senderName : String, senderUrl : String, giftName : String, giftUrl : String) {
        self.senderName = senderName
        self.senderUrl = senderUrl
        self.giftName = giftName
        self.giftUrl = giftUrl
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? GiftAnimationModel else {
            return false
        }
        guard obj.senderName == senderName && obj.giftName == giftName else {
            return false
        }
        return true
    }

}
