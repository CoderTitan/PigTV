//
//  ProfileViewCell.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLable: UILabel!
    
    @IBOutlet weak var titleToImage: NSLayoutConstraint!
    @IBOutlet weak var arrowContent: NSLayoutConstraint!
    var settingModel : SettingItemModel?{
        didSet{
            guard let model = settingModel else {
                return
            }
            
            model.iconImage == "" ? (iconImage.isHidden = true) : (iconImage.image = UIImage(named: model.iconImage))
            titleLabel.text = model.titleText
            detailLable.text = model.detailText
            
            arrowImage.isHidden = (model.type == .arrow || model.type == .arrowDetail) ? false : true
            onSwitch.isHidden = model.type == .onswitch ? false : true
            detailLable.isHidden = (model.type == .arrowDetail || model.type == .detail) ? false : true
            
            titleToImage.constant = model.iconImage == "" ? -40 : 10
            arrowContent.constant = model.type == .detail ? -8 : 8
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
