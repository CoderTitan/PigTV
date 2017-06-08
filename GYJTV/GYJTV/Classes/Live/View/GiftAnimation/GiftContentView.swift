//
//  GiftContentView.swift
//  GiftAnimation
//
//  Created by zcm_iOS on 2017/6/7.
//  Copyright © 2017年 com.zcmlc.zcmlc. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10


class GiftContentView: UIView {

    //MARK: 私有属性
    fileprivate lazy var giftChannelArr : [GiftChannelView] = [GiftChannelView]()
    fileprivate lazy var cacheGiftModels : [GiftAnimationModel] = [GiftAnimationModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 界面处理
extension GiftContentView{
    fileprivate func setupViews(){
        // 根据当前的渠道数，创建HYGiftChannelView
        for i in 0..<kChannelCount {
            let channelView = GiftChannelView.loadFromNib()
            channelView.frame = CGRect(x: 0, y: (kChannelViewH + kChannelMargin) * CGFloat(i), width: frame.width, height: kChannelViewH)
            channelView.alpha = 0
            addSubview(channelView)
            giftChannelArr.append(channelView)
            
            channelView.complectionCallback = {channelView in
                //1.取出缓存中的模型
                guard self.cacheGiftModels.count != 0 else {
                    return
                }
                
                //2.取出缓存中的第一个模型
                let firstmodel = self.cacheGiftModels.first
                
                //3.清除第一个模型
                self.cacheGiftModels.removeFirst()
                
                //4.让闲置的channelView执行动画
                channelView.giftModel = firstmodel
                
                //5.将数组中剩余有和firstGiftModel相同的模型放入到ChanelView缓存中
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstmodel) {
                        channelView.addOnceToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
        }
    }
}

//MARK: 
extension GiftContentView{
    func showGiftModel(_ giftModel : GiftAnimationModel) {
        // 1.判断正在忙的ChanelView和赠送的新礼物的(username/giftname)
        if let channelView = chackUsingChannelView(giftModel){
            channelView.addOnceToCache()
            return
        }
        
        // 2.判断有没有闲置的ChanelView
        if let channelView = chackIdelChannelView(){
            channelView.giftModel = giftModel
            return
        }
        
        // 3.将数据放入缓存中
        cacheGiftModels.append(giftModel)
    }
    
    //判断有没有正在使用的,并且和赠送礼物相同的
    private func chackUsingChannelView(_ giftModel : GiftAnimationModel) -> GiftChannelView?{
        for channelView in giftChannelArr {
            if giftModel.isEqual(channelView.giftModel) && channelView.giftState != .endAnimating {
                return channelView
            }
        }
        return nil
    }
    
    //判断有没有闲置的channelView
    private func chackIdelChannelView() -> GiftChannelView? {
        for channelView in giftChannelArr {
            if channelView.giftState == .idle {
                return channelView
            }
        }
        return nil
    }
}
