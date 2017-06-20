//
//  DiscoverViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class DiscoverViewModel: HomeViewModel {
    
}

extension DiscoverViewModel{
    func loadDiscoverContentData( _ complation : @escaping() -> ()){
        NetworkTool.requestData(.get, URLString: kDiscoverContentList, parameters: ["count" : 20]) { (result) in
            guard let resultDic = result as? [String : Any] else { return }
            guard let message = resultDic["message"] as? [String : Any] else { return }
            guard let anchors = message["anchors"] as? [[String : Any]] else { return }
            for dict in anchors{
                self.anchorModels.append(AnchorModel(dic: dict))
            }
            complation()
        }
    }
}
