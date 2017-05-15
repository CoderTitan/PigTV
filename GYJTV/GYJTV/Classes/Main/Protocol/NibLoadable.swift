//
//  NibLoadable.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
}

extension NibLoadable where Self : UIView{
    static func loadFromNib( _ nibName : String? = nil) -> Self {
        let loadName = nibName  == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
