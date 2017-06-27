//
//  LivingViewController.swift
//  GYJTV
//
//  Created by 田全军 on 2017/6/27.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import LFLiveKit

class LivingViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var beautiCameraBtn: UIButton!
    @IBOutlet weak var videoCameraBtn: UIButton!
    
    // MARK: 懒加载
    fileprivate lazy var session : LFLiveSession = {
        let audioCon = LFLiveAudioConfiguration.default()
        let videoCon = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioCon, videoConfiguration: videoCon)
        session?.preView = self.view
        session?.delegate = self
        return session!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopLive()
    }
    
}

//MARK: 界面处理
extension LivingViewController{
    fileprivate func setupViews(){
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = startButton.frame.height * 0.5
    }
}

//MARK: 事件监听
extension LivingViewController{
    //开始直播
    @IBAction func startLivingClick(_ sender: Any) {
        startButton.isHidden = true
        titleTextField.isHidden = true
        let stream = LFLiveStreamInfo()
        stream.url = "trmp://59.110.27.24/live.quanjun"
        session.running = true
        session.startLive(stream)
    }
    //结束直播
    @IBAction func cancelLivingClick(_ sender: Any) {
        session.stopLive()
        dismiss(animated: true, completion: nil)
    }

    //美颜
    @IBAction func BrautifulCameraClick(_ sender: Any) {
        session.beautyFace = !session.beautyFace
        beautiCameraBtn.isSelected = !beautiCameraBtn.isSelected
        beautiCameraBtn.setImage((beautiCameraBtn.isSelected == false ? UIImage(named: "camra_beauty") : UIImage(named: "camra_beauty_close")), for: .normal)
    }
    
    //切换摄像头
    @IBAction func changeVideoDeviceClick(_ sender: Any) {
        let devicePositon = session.captureDevicePosition
        session.captureDevicePosition = devicePositon == .back ? .front : .back
    }
}

// MARK: 
extension LivingViewController : LFLiveSessionDelegate{
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print(state)
        switch state {
        case .ready:
            stateLabel.text = "未连接"
        case .pending:
            stateLabel.text = "连接中"
        case .start:
            stateLabel.text = "已连接"
        case .error:
            stateLabel.text = "连接错误"
        case .stop:
            stateLabel.text = "未连接"
        case .refresh:
            stateLabel.text = "正在刷新"
        default:
            stateLabel.text = "未知状态"
        }
    }
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        
    }
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print(errorCode)
    }
}

