//
//  DetailRankViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class DetailRankViewModel {
    lazy var rankArray : [RankModel] = [RankModel]()
}

extension DetailRankViewModel{
    func loadDetailRankData(_ rankType : RankType, _ complection : @escaping() -> ()) {
        let urlStr = kRankDetailListUrl + rankType.typeName + ".ios"
        NetworkTool.requestData(.get, URLString: urlStr, parameters: ["pageSize" : 30, "type" : rankType.typeNum]) { (result) in
            self.rankArray.removeAll()
            guard let resultDic = result as? [String : Any] else { return }
            
            guard let message = resultDic["message"] as? [String : Any] else { return }
            
            guard let rankStar = message[rankType.typeName] as? [[String : Any]] else { return }
            
            for dict in rankStar{
                let model = RankModel(dic: dict)
                self.rankArray.append(model)
            }
            complection()
        }
    }
}
