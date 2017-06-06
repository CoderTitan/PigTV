//
//  RoomViewController.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/11.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kChatToolsViewHeight : CGFloat = 44
private let kGiftlistViewHeight : CGFloat = kScreenHeight * 0.43
private let kChatContentViewHeight : CGFloat = 200


class RoomViewController: UIViewController ,Emitterable{
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftListView : GiftListView = GiftListView.loadFromNib()
    fileprivate lazy var chatContentView : ChatContentView = ChatContentView.loadFromNib()
    fileprivate lazy var socket : QJSocket = QJSocket(addr: "192.168.125.117", port: 7878)
    fileprivate var heartBeatTimer : Timer?
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.设置UI界面
        setupUI()
        //2.键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame( _ :)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        //3.连接服务器
        if socket.connectServer() {
            print("连接服务器")
            //开始发送消息
            socket.startReadMsg()
            socket.sendHeartBeat()
            //进入房间
            socket.sendJoinRoom()
            socket.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.sendLeaveRoom()
    }
    deinit {
        heartBeatTimer?.invalidate()
        heartBeatTimer = nil
    }
    
}


// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
    }
    
    //毛玻璃效果iOS8以后才可以
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView(){
        //1.设置Chat内容的View
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - kChatContentViewHeight - 44, width: view.bounds.width, height: kChatContentViewHeight)
        chatContentView.backgroundColor = UIColor.black
        chatContentView.alpha = 0.2
        chatContentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(chatContentView)
        
        //2.设置chatToolsView
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        
        //3.设置礼物列表
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftListView.delegate = self
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
    }
}


// MARK:- 事件监听
extension RoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolsView.inputTextField.becomeFirstResponder()
        case 1:
            print("点击了分享")
        case 2:
            UIView.animate(withDuration: 0.35, animations: { 
                self.giftListView.frame.origin.y = kScreenHeight - kGiftlistViewHeight
            })
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            startEmittering(point)
        default:
            fatalError("未处理按钮")
        }
    }
    
}

// MARK: 给服务器发送即时消息
extension RoomViewController{
    fileprivate func addHeaderBeatTimer(){
        heartBeatTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeaderBeatMsg), userInfo: nil, repeats: true)
        RunLoop.main.add(heartBeatTimer!, forMode: .commonModes)
    }
    @objc fileprivate func sendHeaderBeatMsg(){
        socket.sendHeartBeat()
    }
}

// MARK: 键盘监听
extension RoomViewController{
    //
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification){
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputTextY = endFrame.origin.y - kChatToolsViewHeight
        
        UIView.animate(withDuration: duration) { 
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            let endY = inputTextY == (kScreenHeight - kChatToolsViewHeight) ? kScreenHeight : inputTextY
            self.chatToolsView.frame.origin.y = endY
            
            //改变聊天信息展示框的位置
            let contentEndY = inputTextY == (kScreenHeight - kChatToolsViewHeight) ? (kScreenHeight - kChatContentViewHeight - 44) : endY - kChatContentViewHeight
            self.chatContentView.frame.origin.y = contentEndY
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolsView.inputTextField.resignFirstResponder()
    }

}

// MARK: QJSocketDelegate
//接受聊天服务器返回的消息
extension RoomViewController : QJSocketDelegate{
    //进入房间
    func socket(_ socket: QJSocket, joinRoom user: UserInfo) {
        chatContentView.insertMessage(AttributeStrGenerator.generateJoinAndLevelRoom(user.name, true))
    }
    
    //离开房间
    func socket(_ socket: QJSocket, leaveRoom user: UserInfo) {
        chatContentView.insertMessage(AttributeStrGenerator.generateJoinAndLevelRoom(user.name, false))
    }
    
    //普通消息
    func socket(_ socket: QJSocket, chatMsg: ChatMessage) {
        chatContentView.insertMessage(AttributeStrGenerator.generateTextMessage(chatMsg.user.name, chatMsg.text))
    }
    
    //礼物消息
    func socket(_ socket: QJSocket, giftMsg: GiftMessage) {
        chatContentView.insertMessage(AttributeStrGenerator.genetateGiftMessage(giftMsg.user.name, giftMsg.giftname, giftMsg.giftUrl))
    }
}

//MARK: ChatToolsViewDelegate, GiftListViewDelegate
extension RoomViewController : ChatToolsViewDelegate, GiftListViewDelegate{
    func chatTiilsView(chatToolsView: ChatToolsView, message: String) {
        socket.sendTextMsg(message: message)
    }
    func giftListView(giftListView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftName: giftModel.subject, giftURL: giftModel.img2, giftCount: 2)
    }
}
