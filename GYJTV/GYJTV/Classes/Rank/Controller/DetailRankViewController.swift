//
//  DetailRankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kDetailRankCell : String = "detailRank"

class DetailRankViewController: UIViewController {

    //MARK: 对外属性
    var rankType : RankType
    lazy var tableView : UITableView = UITableView()
    
    //MARK: 私有属性
    fileprivate lazy var detailVM : DetailRankViewModel = DetailRankViewModel()
    
    init(rankType : RankType) {
        self.rankType = rankType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadTableViewData()
    }
}

//MARK: 界面数据处理
extension DetailRankViewController{
    fileprivate func setupTableView(){
        tableView.frame = view.bounds
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0)
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "DetailRankTableCell", bundle: nil), forCellReuseIdentifier: kDetailRankCell)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadTableViewData))
        tableView.mj_header.beginRefreshing()
    }
    
    func loadTableViewData(){
        detailVM.loadDetailRankData(rankType) { 
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
}

//MARK: tableView代理
extension DetailRankViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailVM.rankArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kDetailRankCell, for: indexPath) as! DetailRankTableCell
        cell.rankModel = detailVM.rankArray[indexPath.row]
        cell.rankNum = indexPath.row
        return cell
    }
}
