//
//  ChatContentView.swift
//  GYJTV
//
//  Created by 田全军 on 2017/6/5.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kChatContentCell = "kChatContentCell"

class ChatContentView: UIView, NibLoadable {

    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var messageArr : [NSAttributedString] = [NSAttributedString]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        tableView.register(ChatContentCell.self, forCellReuseIdentifier: kChatContentCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        //高度的自动布局
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //添加消息
    func insertMessage(_ message : NSAttributedString) {
        messageArr.append(message)
        tableView.reloadData()
        //tableView移动到最后一条消息的位置
        let indexPath = IndexPath(row: messageArr.count - 1, section: 0)
        UIView.animate(withDuration: 0.25) {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ChatContentView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatContentCell, for: indexPath) as! ChatContentCell
        cell.contentLabel.attributedText = messageArr[indexPath.row]
        return cell
    }
}
