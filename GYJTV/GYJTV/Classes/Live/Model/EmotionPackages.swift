//
//  EmotionPackages.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class EmotionPackages {

    lazy var emotionsArray : [EmotionModel] = [EmotionModel]()
    
    //解析plist文件
    init(plistName : String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else {
            return
        }
        
        guard let emotionArray = NSArray(contentsOfFile: path) as? [String] else {
            return
        }
        for str in emotionArray{
            emotionsArray.append(EmotionModel(emoticonName: str))
        }
    }
    
}
