//
//  DiscoverCollectionCell.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class DiscoverCollectionCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var isLiveImage: UIImageView!
    
    var anchor : AnchorModel?  {
        didSet {
            guard let anchor = anchor else { return }
            
            numberLable.text = "\(anchor.focus)人观看"
            nameLabel.text = anchor.name
            iconImage.setImage(anchor.pic51, "home_pic_default")
            isLiveImage.isHidden = anchor.live == 0
        }
    }
}
