//
//  DiscoverViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kCourseViewHeight : CGFloat = kScreenWidth * 0.4
fileprivate let kTableViewRowHeight : CGFloat = kScreenWidth * 1.4
fileprivate let kTableHeaderSectionHeight : CGFloat = 40

fileprivate let kTableViewCellId : String = "discoverell"

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var courseView : CourseHeaderVIew = {
        let courseView = CourseHeaderVIew(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kCourseViewHeight))
        courseView.delegate = self
        return courseView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.white
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        courseView.stopTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        courseView.startTimer()
    }
}

//MARK: 界面数据
extension DiscoverViewController{
    fileprivate func setupViews(){
        automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = kTableViewRowHeight
        tableView.tableHeaderView = courseView
        tableView.tableFooterView = setTableSectionFooterView()
        tableView.register(DiscoverTableCell.self, forCellReuseIdentifier: kTableViewCellId)
    }
    
    fileprivate func addRefreshView(){
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(tableViewHeaderRefresh))
        tableView.mj_header.beginRefreshing()
    }
    
    fileprivate func setTableSectionHeaderView() -> UIView{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: kTableHeaderSectionHeight))
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: kTableHeaderSectionHeight))
        headerLabel.text = "猜你喜欢"
        headerLabel.textColor = UIColor.orange
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    fileprivate func setTableSectionFooterView() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 80))
        footerView.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        let footerBtn = UIButton(type: .custom)
        let point = footerView.center
        
        footerBtn.center = point
        footerBtn.frame = CGRect(x: footerView.frame.width * 0.25, y: footerView.frame.height * 0.25, width: footerView.frame.width * 0.5, height: footerView.frame.height * 0.5)
        footerBtn.setTitle("换一换", for: .normal)
        footerBtn.setTitleColor(UIColor.black, for: .normal)
        footerBtn.layer.borderColor = UIColor.red.cgColor
        footerBtn.layer.borderWidth = 1
        footerBtn.layer.masksToBounds = true
        footerBtn.layer.cornerRadius = 5
        footerBtn.addTarget(self, action: #selector(nextPageBittonClick), for: .touchUpInside)
        footerView.addSubview(footerBtn)
        return footerView
    }

}

//MARK: 监听事件处理
extension DiscoverViewController{
    //下拉刷新
    @objc fileprivate func tableViewHeaderRefresh(){
        //头部轮播图
        courseView.loadCourseData()
        //中间内容
        let cell = tableView.visibleCells.first as? DiscoverTableCell
        cell?.loadContentData()
        tableView.mj_header.endRefreshing()
    }

    //换一换
    @objc fileprivate func nextPageBittonClick(){
        let cell = tableView.visibleCells.first as? DiscoverTableCell
        cell?.refreNextPageData()
        tableView.setContentOffset(CGPoint(x: 0, y: kCourseViewHeight), animated: true)
    }
}

//MARK: tableView代理
extension DiscoverViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellId, for: indexPath) as! DiscoverTableCell
        cell.cellDidSelected = {(anchor : AnchorModel) in
            let room = RoomViewController()
            room.anchorM = anchor
            self.navigationController?.pushViewController(room, animated: true)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setTableSectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kTableHeaderSectionHeight
    }
}

//MARK: courseVie
extension DiscoverViewController : CourseHeaderViewDelegate{
    func courseHeaderView(_ courseView: CourseHeaderVIew, didSelectItemAt courseModel: CourseModel) {
        let webVC = WebViewController()
        webVC.hidesBottomBarWhenPushed = true
        webVC.webUrl = courseModel.linkUrl
        navigationController?.pushViewController(webVC, animated: true)
    }
}
