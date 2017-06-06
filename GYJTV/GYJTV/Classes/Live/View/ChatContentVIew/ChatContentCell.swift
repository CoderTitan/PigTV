//
//  ChatContentCell.swift
//  GYJTV
//
//  Created by 田全军 on 2017/6/5.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class ChatContentCell: UITableViewCell {

    var contentLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        backgroundColor = UIColor.clear
        selectionStyle = .none
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor.white
        contentView.addSubview(contentLabel)
        contentView.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.frame = CGRect(x: 20, y: 5, width: contentView.frame.width - 20 * 2, height: contentView.frame.height - 5 * 2)

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
