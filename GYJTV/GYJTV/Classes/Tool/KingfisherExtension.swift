//
//  KingfisherExtension.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/21.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(_ urlString : String?, _ placeHolderName : String? = nil) {
        guard let urlString = urlString else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let placeHolderName = placeHolderName else {
            kf.setImage(with: url)
            return
        }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }
}
