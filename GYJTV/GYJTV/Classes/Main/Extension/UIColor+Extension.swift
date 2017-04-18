//
//  UIColor+Extension.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/13.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

extension UIColor{
    
    /**RGB三原色
     - returns: 在extension中给系统类扩充构造函数,只能扩充"便利构造函数"
     */
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /**
     *  十六进制颜色扩充
     */
    convenience init?(hex : String, alpha : CGFloat = 1.0) {
        //1.判断字符串长度是否符合
        guard hex.characters.count >= 6 else {
            return nil
        }
        //2.将字符串转成大写
        var tempHex = hex.uppercased()
        //3.判断开头
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        //4.分别截取RGB
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        //5.将字符串转化成数字  emoji也是十六进制表示
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        //创建扫描器,将字符串的扫描结果赋值给:r,g,b
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))
    }
    
    /**
     *  随机颜色
     */
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
