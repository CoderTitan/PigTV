//
//  ShadeView.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/24.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

protocol ShadeViewDelegate : class{
    func shadeViewDidSelector(_ shadeView : ShadeView)
}
class ShadeView: UIView {

    weak var delegate : ShadeViewDelegate?
    
    fileprivate lazy var videoBtn = UIButton(type: .custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadeView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 界面处理
extension ShadeView{
    fileprivate func setupShadeView(){
        backgroundColor = UIColor.black
        alpha = 0.8
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        videoBtn.frame = CGRect(x: (kScreenWidth - 60) * 0.5, y: kScreenHeight, width: 60, height: 60)
        videoBtn.setImage(UIImage(named: "live_neo"), for: .normal)
        videoBtn.alpha = 1.0
        videoBtn.addTarget(self, action: #selector(videoButtonClick), for: .touchUpInside)
        addSubview(videoBtn)
        
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.frame = CGRect(x: (kScreenWidth - 40) * 0.5, y: kScreenHeight - 60, width: 40, height: 40)
        cancelBtn.setImage(UIImage(named: "camera_cancel"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.dismissShadeView), for: .touchUpInside)
        addSubview(cancelBtn)
    }
    
    @objc fileprivate func videoButtonClick(){
        dismissShadeView()
        delegate?.shadeViewDidSelector(self)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissShadeView()
    }
}

//MARK: 显示/隐藏视图
extension ShadeView{
    func showShadeView(){
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.videoBtn.frame.origin.y = kScreenHeight - 250
        }) { (true) in
            print("ok")
        }
    }
    
    @objc func dismissShadeView(){
        removeFromSuperview()
    }
}
