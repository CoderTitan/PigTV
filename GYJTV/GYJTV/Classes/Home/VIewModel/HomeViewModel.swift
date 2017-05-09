//
//  HomeViewModel.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/21.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class HomeViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension HomeViewModel {
    func loadHomeData(type : HomeType, index : Int,  finishedCallback : @escaping () -> ()) {
        NetworkTool.requestData(.get, URLString: kHomeDataListUrl, parameters: ["type" : type.type, "index" : index, "size" : 48], finishedCallback: { (result) -> Void in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            
            for (index, dict) in dataArray.enumerated() {
                let anchor = AnchorModel(dic: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            
            finishedCallback()
        })
    }
}
