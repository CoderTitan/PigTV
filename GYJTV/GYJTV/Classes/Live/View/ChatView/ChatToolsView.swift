//
//  ChatToolsView.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

//MARK: 信息回调协议
protocol ChatToolsViewDelegate : class{
    func chatTiilsView(chatToolsView : ChatToolsView, message: String)
}

class ChatToolsView: UIView , NibLoadable{

    // MARK: 属性
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    fileprivate lazy var emoticonBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    fileprivate lazy var emotionView : EmotionView = EmotionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 250))
    weak var delegate : ChatToolsViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onfinishViews()
    }
    
    @IBAction func sendButtonclick(_ sender: UIButton) {
        //获取内容
        guard let message = inputTextField.text else {
            return
        }
        if message == "" {
            sender.isEnabled = false
            return
        }
        ///清空内容
        inputTextField.text = ""
        //发送消息
        delegate?.chatTiilsView(chatToolsView: self, message: message)
    }

    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        sendMsgBtn.isEnabled = sender.text!.characters.count != 0
    }
}

// MARK:初始化界面
extension ChatToolsView{
    fileprivate func onfinishViews(){
        // 1.初始化inputView中rightView
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true  //可编辑
        
        // 2.设置emotionView的闭包(weak当对象销毁值, 会自动将指针指向nil)
        emotionView.emotionClickCallBack = {[weak self] emoticon in
            // 1.判断是否是删除按钮
            if emoticon.emoticonName == "delete-n" {
                self?.inputTextField.deleteBackward()
                return
            }
            // 2.获取光标位置
            guard let range = self?.inputTextField.selectedTextRange else { return }
            self?.inputTextField.replace(range, withText: emoticon.emoticonName)
        }
    }
}

// MARK: 事件监听
extension ChatToolsView{
    @objc fileprivate func emoticonBtnClick(_ button : UIButton){
        button.isSelected = !button.isSelected
        //切换键盘
        //获取光标所在位置
        let range = inputTextField.selectedTextRange
        inputTextField.resignFirstResponder()
        inputTextField.inputView = inputTextField.inputView == nil ? emotionView : nil
        inputTextField.becomeFirstResponder()
        inputTextField.selectedTextRange = range
    }
}
