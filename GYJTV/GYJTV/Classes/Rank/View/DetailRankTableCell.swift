//
//  DetailRankTableCell.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class DetailRankTableCell: UITableViewCell {

    @IBOutlet weak var rankNumBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var liveImageView: UIImageView!

    var rankNum : Int = 0 {
        didSet {
            if rankNum < 3 {
                rankNumBtn.setTitle("", for: .normal)
                let iconImage = UIImage(named:"ranking_icon_no\(rankNum + 1)")?.withRenderingMode(.alwaysOriginal)
                rankNumBtn.setImage(iconImage, for: .normal)
            } else {
                rankNumBtn.setImage(nil, for: .normal)
                rankNumBtn.setTitle("\(rankNum + 1)", for: .normal)
            }
        }
    }

    var rankModel : RankModel? {
        didSet {
            guard let rank = rankModel else { return }
            iconImageView.setImage(rank.avatar)
            nickNameLabel.text = rank.nickname
            liveImageView.isHidden = rank.isInLive == 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.layer.masksToBounds = true
    }
}
