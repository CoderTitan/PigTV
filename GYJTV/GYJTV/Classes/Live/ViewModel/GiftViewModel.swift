//
//  GiftViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/5/25.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class GiftViewModel: NSObject {

    lazy var giftListData : [GiftPackages] = [GiftPackages]()
}

extension GiftViewModel{
    func loadGiftData(finishedCallBack : @escaping () -> ()) {
        // http://qf.56.com/pay/v4/giftList.ios?type=0&page=1&rows=150
        
        if giftListData.count != 0 {  finishedCallBack() }
        //请求数据
        NetworkTool.requestData(.get, URLString: kRoomGiftListUrl, parameters: ["type" : 0, "page" : 1, "rows" : 150], finishedCallback: { result in
            
            guard let resultDic = result as? [String : Any] else { return }
            guard let message = resultDic["message"] as? [String : Any] else { return }
            
            for i in 0..<message.count{
                guard let type = message["type\(i + 1)"] as? [String : Any] else { continue }
                self.giftListData.append(GiftPackages(dic: type))
            }
            //先过滤掉没有礼物的数组,再按照有多到少排序
            self.giftListData = self.giftListData.filter({ return $0.list.count > 0 }).sorted(by: { return $0.list.count > $1.list.count })
            
            finishedCallBack()
        })
    }
}
