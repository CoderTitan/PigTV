//
//  RoomViewModel.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class RoomViewModel {
    //视频播放地址
    lazy var liveUrl : String = ""

}

extension RoomViewModel{
    //imei=36301BB0-8BBA-48B0-91F5-33F1517FA056&roomId=520789&signature=f69f4d7d2feb3840f9294179cbcb913f&userId=wlunm356_561565294
    func loadLiveUrl(uid : String, roomID : String, _ complection : @escaping ()-> ()){
        let pares = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056",
                     "roomId" : roomID,
                     "signature" : "f69f4d7d2feb3840f9294179cbcb913f",
                     "userId" : uid]
        NetworkTool.requestData(.get, URLString: kRoomOnLiveUrl, parameters: pares) { (result) in
            //1.获取结果字典
            guard let resultDic = result as? [String : Any] else { return }
            //2.获取message对应返回值
            guard let message = resultDic["message"] as? [String : Any] else { return }
            //3.获取rurl参数返回值
            guard let rurl = message["rUrl"] as? String  else { return }

            //4.q请求直播地址
            self.loadOnLiveUrl(urlString: rurl, complection)
        }
    }
    
    fileprivate func loadOnLiveUrl(urlString : String, _ complection : @escaping () -> ()){
        NetworkTool.requestData(.get, URLString: urlString) { (result) in
            //1.获取结果字典
            guard let resultDic = result as? [String : Any] else { return }
            //2.获取url参数返回值
            guard let url = resultDic["url"] as? String  else { return }
            //3.赋值
            self.liveUrl = url
            //4.回调
            complection()
        }
    }
}
