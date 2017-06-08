//
//  GiftDigitLabel.swift
//  GiftAnimation
//
//  Created by zcm_iOS on 2017/6/3.
//  Copyright © 2017年 com.zcmlc.zcmlc. All rights reserved.
//

import UIKit

class GiftDigitLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        //1.获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        
        //2.给上下文线段设置一个宽度,通过该宽度画出文本
        context?.setLineWidth(5)
        //添加的模式;round:画出的线段会有圆角
        context?.setLineJoin(.round)
        //stroke:话周围的边界
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        //画到rect区域内
        super.drawText(in: rect)
        
        //充满内部的部分
        context?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        super.drawText(in: rect)
    }
}

//MARK: 对外方法
extension GiftDigitLabel{
    
    func showDigitAnimation(_ complection : @escaping () -> ()) {
        //反复执行动画:delay,延迟
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            //animateKeyframes动画组内只能写addKeyframe动画效果
            
            //动画组,,,事件从0.0开始,持续:0.25的0.5倍
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                //缩放
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: { 
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
        }) { (isFinished) in
            /**
             * 弹簧效果,
             * usingSpringWithDamping   弹性阻尼系数取值0~1，值越大，弹框幅度越小 
             * initialSpringVelocity    初始速度
             */
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: { 
                self.transform = CGAffineTransform.identity
            }, completion: { (isfinished) in
                complection()
            })
        }
    }
}
