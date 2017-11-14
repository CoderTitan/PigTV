//
//  String-Extension.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import Foundation
import UIKit

extension String{
    static var documentPath : String{
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
}


extension UIViewController{
    //删除原有浮框
    func dismissScreenListPlayView(){
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        let windows = keyWindow.subviews
        for window in windows {
            if String(describing: window.self).contains("RoomPlayView") {
                if let view = window as? RoomPlayView {
                    view.dismissPlayView()
                }
            }
        }
    }
}
