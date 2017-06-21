//
//  WeeklyRankViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class WeeklyRankViewModel {
    lazy var weeklyArray : [[WeeklyModel]] = [[WeeklyModel]]()
}

extension WeeklyRankViewModel{

    func loadWeeklyRequestData(_ rankType : RankType, _ complection : @escaping() -> ()){
        let signature = rankType.typeNum == 1 ? "b4523db381213dde637a2e407f6737a6" : "d23e92d56b1f1ac6644e5820eb336c3e"
        let ts = rankType.typeNum == 1 ? "1480399365" : "1480414121"
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "pageSize" : 30, "signature" : signature, "ts" : ts, "weekly" : rankType.typeNum - 1]
        
        NetworkTool.requestData(.get, URLString: kRankWeeklyListUrl, parameters: parameters) { (result) in
            //1.清空数据
            self.weeklyArray.removeAll()
            //2.转成字典
            guard let resultDic = result as? [String : Any] else { return }
            //3.取出数据字典
            guard let message = resultDic["message"] as? [String : Any] else { return }
            
            //3.主播数据
            if let anchorRank = message["anchorRank"] as? [[String : Any]]  {
                self.addDataToWeeklyRanks(dataArr: anchorRank)
            }
            //4.粉丝数据
            if let fansDataArray = message["fansRank"] as? [[String : Any]]{
                self.addDataToWeeklyRanks(dataArr: fansDataArray)
            }
            //5.回调
            complection()
        }
    }
    
    fileprivate func addDataToWeeklyRanks(dataArr : [[String : Any]]){
        var weeklys = [WeeklyModel]()
        for dict in dataArr{
            weeklys.append(WeeklyModel(dic: dict))
        }
        weeklyArray.append(weeklys)
    }
}
