//
//  EmotionViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class EmotionViewModel {

    static let shareInstance : EmotionViewModel = EmotionViewModel()
    lazy var emotionPackArray : [EmotionPackages] = [EmotionPackages]()
    
    init() {
        emotionPackArray.append(EmotionPackages(plistName: "QHNormalEmotionSort.plist"))
        emotionPackArray.append(EmotionPackages(plistName: "QHSohuGifSort.plist"))
    }
}
