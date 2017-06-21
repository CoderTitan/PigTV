//
//  WeeklyRankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kWeeklyRankCell : String = "weeklyRank"

class WeeklyRankViewController: DetailRankViewController {

    //MARK: 私有属性
    fileprivate lazy var weeklyVM : WeeklyRankViewModel = WeeklyRankViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 60
        tableView.contentInset = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "WeeklyRankTableCell", bundle: nil), forCellReuseIdentifier: kWeeklyRankCell)
    }
    
    override init(rankType: RankType) {
        super.init(rankType: rankType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 界面数据处理
extension WeeklyRankViewController{
    override func loadTableViewData() {
        weeklyVM.loadWeeklyRequestData(rankType) { 
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
}

//MARK: tableView代理
extension WeeklyRankViewController{
    func numberOfSections(in tableView: UITableView) -> Int {
        return weeklyVM.weeklyArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyVM.weeklyArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kWeeklyRankCell, for: indexPath) as! WeeklyRankTableCell
        cell.weekly = weeklyVM.weeklyArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        header.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: 30))
        title.backgroundColor = UIColor.clear
        title.text = section == 0 ? "主播周星榜" : "富豪周星榜"
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = UIColor.orange
        header.addSubview(title)
        return header
    }
}
