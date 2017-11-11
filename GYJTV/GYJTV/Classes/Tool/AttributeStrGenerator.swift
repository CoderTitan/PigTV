//
//  AttributeStrGenerator.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/6.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import Kingfisher

class AttributeStrGenerator {

}

extension AttributeStrGenerator{
    
    //进入/离开房间
    class func generateJoinAndLevelRoom(_ userName : String, _ isJoin : Bool) -> NSAttributedString {
        let roomString = "\(userName)" + (isJoin ? "进入房间" : "离开房间")
        let roomAtt = NSMutableAttributedString(string: roomString)
        roomAtt.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: userName.characters.count))
        return roomAtt
    }
    
    //表情文字消息
    class func generateTextMessage(_ username : String, _ message : String) -> NSAttributedString{
        //1.获取整个字符串
        let chatMsg = username + ":" + message
        
        //2.该名称为橘色
        let chatAttr = NSMutableAttributedString(string: chatMsg)
        chatAttr.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: username.characters.count))
        // 3.将所有表情匹配出来, 并且换成对应的图片进行展示
        // 3.1.创建正则表达式匹配表情 我是主播[哈哈], [嘻嘻][嘻嘻] [123444534545235]
        let pattern = "\\[.*?\\]"
        guard let reges = try? NSRegularExpression(pattern: pattern, options: []) else {
            return chatAttr
        }
        let results = reges.matches(in: chatMsg, options: [], range: NSRange(location: 0, length: chatMsg.characters.count))
        
        //3.2获取表情的结果:从后往前解析表情
        //reverser:使数组倒叙输出
        for i in (0..<results.count).reversed() {
            //3.3获取结果
            let result = results[i]
            let emotion = (chatMsg as NSString).substring(with: result.range)
            //3.4根据结果创建对应的图片
            guard let image = UIImage(named: emotion) else {
                continue
            }
            
            //3.5根据图片创建NSTextAttachment
            let attachment = NSTextAttachment()
            attachment.image = image
            let font = UIFont.systemFont(ofSize: 15)
            attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
            let imageAttStr = NSAttributedString(attachment: attachment)
            
            //3.6讲imageAttStr替换到之前的文本位置
            chatAttr.replaceCharacters(in: result.range, with: imageAttStr)
        }
        return chatAttr
    }
    
    //礼物消息
    class func genetateGiftMessage(_ username : String, _ giftname : String, _ gifturl : String) -> NSAttributedString{
        //1.获取赠送礼物的字符串
        let giftMessage = "\(username) 为主播赠送了 \(giftname) "
        //2.修改用户名称
        let giftAttribute = NSMutableAttributedString(string: giftMessage)
        giftAttribute.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: username.characters.count))
        
        //3.修改礼物名称
        let range = (giftMessage as NSString).range(of: giftname)
        giftAttribute.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.red], range: range)
        
        //4.最后拼接礼物图片
        guard let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: gifturl) else {
            return giftAttribute
        }
        //5.设置图片
        let attachment = NSTextAttachment()
        attachment.image = image
        let font = UIFont.systemFont(ofSize: 15)
        attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
        let imageAttStr = NSAttributedString(attachment: attachment)
        giftAttribute.append(imageAttStr)
        //6.拼接
        return giftAttribute
    }
}


