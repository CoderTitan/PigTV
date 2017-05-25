//
//  EmoticonViewCell.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/24.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    var emoticon : EmotionModel? {
        didSet {
            iconImageView.image = UIImage(named: emoticon!.emoticonName)
        }
    }
}
