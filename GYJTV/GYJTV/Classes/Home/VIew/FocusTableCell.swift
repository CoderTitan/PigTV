//
//  FocusTableCell.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/23.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class FocusTableCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onliveImage: UIImageView!
    
    var anchorModel : AnchorModel?{
        didSet{
            guard let anchor = anchorModel else {
                return
            }
            
            let iconStr = anchor.pic51 == "" ? anchor.pic74 : anchor.pic51
            iconImage.setImage(iconStr)
            nickNameLabel.text = anchor.name
            
            onliveImage.isHidden = anchor.live == 0 ? true : false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.layer.masksToBounds = true
        iconImage.layer.cornerRadius = iconImage.frame.height
    }
    
}
