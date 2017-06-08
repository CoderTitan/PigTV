//
//  GiftChannelView.swift
//  GiftAnimation
//
//  Created by zcm_iOS on 2017/6/3.
//  Copyright © 2017年 com.zcmlc.zcmlc. All rights reserved.
//

import UIKit

enum GiftChannelState {
    case idle           //闲置状态
    case animating      //正在执行
    case willEnd        //即将结束
    case endAnimating   //结束动画
}

class GiftChannelView: UIView, NibLoadable {

    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: GiftDigitLabel!

    fileprivate var cacheNumber : Int = 0
    fileprivate var currentNumber : Int = 0
    var giftState : GiftChannelState = .idle
    var complectionCallback : ((GiftChannelView) -> Void)?
    
    
    var giftModel : GiftAnimationModel? {
        didSet{
            //1.对模型进行校验
            guard let model = giftModel  else {
                return
            }
            
            //2.给控件设置信息
            iconImageView.image = UIImage(named: model.senderUrl)
            senderLabel.text = model.senderName
            giftDescLabel.text = "送出礼物：【\(model.giftName)】"
            giftImageView.setImage(model.giftUrl, "prop_b")
            digitLabel.textAlignment = .center
            
            //3.弹出视图
            giftState = .animating
            performAnimation()
        }
    }
}

//MARK: 界面处理
extension GiftChannelView{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
}

//MARK: 对外提供函数
extension GiftChannelView{
    //增加到缓存里面(缓存个数)
    func addOnceToCache() {
        if giftState == .willEnd {
            performDigitAnimation()

            /**取消本类perform的操作
             * 使3.0秒,重新归0计算
             * self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
             */
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }else{
            cacheNumber += 1
        }
    }
}


// MARK:- 执行动画代码
extension GiftChannelView {
    fileprivate func performAnimation() {
        digitLabel.alpha = 1.0
        digitLabel.text = " X1 "
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
            self.frame.origin.x = 0
        }) { (isFinished) in
            self.performDigitAnimation()
        }
    }
    
    //label执行动画
    fileprivate func performDigitAnimation(){
        currentNumber += 1
        digitLabel.text = " X\(currentNumber) "
        digitLabel.showDigitAnimation {
            if self.cacheNumber > 0{
                self.cacheNumber -= 1
                self.performDigitAnimation()
            }else{
                self.giftState = .willEnd
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
            }
        }
    }

    //执行结束动画
    @objc fileprivate func performEndAnimation(){
        giftState = .endAnimating
        UIView.animate(withDuration: 0.25, animations: { 
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0
        }) { (isFinished) in
            self.currentNumber = 0
            self.cacheNumber = 0
            self.giftModel = nil
            self.frame.origin.x = -self.frame.width
            self.giftState = .idle
            self.digitLabel.alpha = 0
            if let complectionCallback = self.complectionCallback{
                complectionCallback(self)
            }
        }
    }
}
