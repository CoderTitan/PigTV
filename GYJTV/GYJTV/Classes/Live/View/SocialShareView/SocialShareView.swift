//
//  SocialShareView.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/8.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class SocialShareView: UIView, NibLoadable {
    @IBOutlet var shareBtns: [TopImageButton]!
    
    @IBAction func shareBtnClick(_ sender: TopImageButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = "abcd"
    }
}

extension SocialShareView{
    func showSocialShareView(){
        //1.改变按钮的位置
        for btn in shareBtns {
            btn.transform = CGAffineTransform(translationX: 0, y: 200)
        }
        //2.回复按钮的位置
        for (index, btn) in shareBtns.enumerated() {
            UIView.animate(withDuration: 0.5, delay: 0.25 + Double(index) * 0.02, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveLinear, animations: { 
                btn.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
