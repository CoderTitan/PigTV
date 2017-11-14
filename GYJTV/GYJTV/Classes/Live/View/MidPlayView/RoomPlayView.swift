//
//  RoomPlayView.swift
//  GYJTV
//
//  Created by iOS_Tian on 2017/11/13.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import IJKMediaFramework


class RoomPlayView: UIView {

    var livingUrl: String! /// 视频直播地址
    fileprivate var anchorModel: AnchorModel!
    fileprivate var bgImageView = UIImageView()
    fileprivate var ijkPlayer: IJKFFMoviePlayerController?
    
    
    init(frame: CGRect, livingUrl: String = "", anchorM: AnchorModel) {
        super.init(frame: frame)
        
        self.livingUrl = livingUrl
        self.anchorModel = anchorM

        setupViews()
        
        //视频播放
        setPlayerVideo()
    }
    
    fileprivate func setupViews(){
        isUserInteractionEnabled = true
        backgroundColor = UIColor.black
        bgImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(bgImageView)
        
        let closeBtn = UIButton(frame: CGRect(x: frame.width - 30, y: 0, width: 30, height: 30))
        closeBtn.setImage(UIImage(named: "menu_btn_close"), for: .normal)
        closeBtn.backgroundColor = UIColor.clear
        closeBtn.addTarget(self, action: #selector(liveCloseAction(_:)), for: .touchUpInside)
        addSubview(closeBtn)
        
        //添加手势
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gotoRoomViewAction)))
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(pan:))))
    }
    
    //播放视频
    fileprivate func setPlayerVideo(){
        let imageUrl = anchorModel.pic74 == "" ? anchorModel.pic51 : anchorModel.pic74
        bgImageView.setImage(imageUrl, "home_pic_default")
        IJKFFMoviePlayerController.setLogReport(false)
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: livingUrl, with: nil)
        ijkPlayer?.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        bgImageView.insertSubview(ijkPlayer!.view, at: 1)
        DispatchQueue.global().async {
            self.ijkPlayer?.prepareToPlay()
            self.ijkPlayer?.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 事件监听
extension RoomPlayView {
    //关闭浮框
    @objc fileprivate func liveCloseAction(_ sender: Any) {
        dismissPlayView()
    }
    
    //点击浮框
    @objc fileprivate func gotoRoomViewAction(){
        let roomVC = RoomViewController()
        roomVC.anchorM = anchorModel
        roomVC.hidesBottomBarWhenPushed = true
        ControllerManager.visibleViewController?.present(roomVC, animated: true, completion: nil)
        
        //删除浮框
        dismissPlayView()
    }
    
    //拖动浮框
    @objc fileprivate func panGestureAction(pan: UIPanGestureRecognizer){
        let point = pan.translation(in: UIApplication.shared.keyWindow)
        var centerX = center.x + point.x
        var centerY = center.y + point.y
        if frame.minX < 0 {
            centerX = frame.width / 2
        }else if frame.maxX > kScreenWidth {
            centerX = kScreenWidth - frame.width / 2
        }else if frame.minY < 64 {
            centerY = 64 + frame.height / 2
        }else if frame.maxY > kScreenHeight - 49 {
            centerY = kScreenHeight - 49 - frame.height / 2
        }
        
        center = CGPoint(x: centerX, y: centerY)
        pan.setTranslation(.zero, in: UIApplication.shared.keyWindow)
    }
}

extension RoomPlayView {
    //显示浮框
    func showPlayView(){
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //浮框消失
    @objc func dismissPlayView(){
        ijkPlayer?.stop()
        ijkPlayer?.shutdown()
        removeFromSuperview()
    }
}
