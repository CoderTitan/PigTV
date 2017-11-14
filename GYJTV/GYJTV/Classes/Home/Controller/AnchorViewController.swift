//
//  AnchorViewController.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import MJRefresh

private let kEdgeMargin : CGFloat = 8
private let kHomeCellID : String = "homeCell"

class AnchorViewController: UIViewController {
    
    // MARK: 对外属性
    var homeType : HomeType!
    
    
    // MARK: 定义属性
    fileprivate lazy var homeView : HomeViewModel = HomeViewModel()
    fileprivate lazy var collectionView : UICollectionView = {
       let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin
        layout.dataSource = self
        
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collection.backgroundColor = UIColor.white
        collection.register(UINib.init(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kHomeCellID)
        return collection
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        //刷新控件
        collectionViewRefresh()
    }
}

// MARK: 设置界面和刷新控件
extension AnchorViewController{
    fileprivate func setupViews(){
        view.addSubview(collectionView)
    }
    
    //添加上拉下拉刷新
    fileprivate func collectionViewRefresh(){
        //下拉刷新
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadHeaderDataWithIndex))
        //上拉加载
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadFooterDataWithIndex))
        //进入页面开始刷新
        collectionView.mj_header.beginRefreshing()

    }
    
    @objc fileprivate func loadHeaderDataWithIndex() {
        //下拉刷新时,停止上拉加载
        if collectionView.mj_footer.isRefreshing {
            collectionView.mj_footer.endRefreshing()
        }
        collectionView.mj_header.beginRefreshing()
        homeView.loadHomeData(type: homeType, index : 0, finishedCallback: {
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        })
    }
    @objc fileprivate func loadFooterDataWithIndex() {
        //上拉加载时,停止下拉刷新
        if collectionView.mj_header.isRefreshing {
            collectionView.mj_header.endRefreshing()
        }
        collectionView.mj_footer.beginRefreshing()
        homeView.loadHomeData(type: homeType, index : homeView.anchorModels.count, finishedCallback: {
            if self.homeView.anchorModels.count <= 0{
                
            }
            self.collectionView.reloadData()
            self.collectionView.mj_footer.endRefreshing()
        })
    }

}

// MARK: WaterfallLayoutDataSource
extension AnchorViewController : WaterfallLayoutDataSource{
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? kScreenWidth * 2 / 3 : kScreenWidth * 0.5
    }
}
// MARK: UICollectionViewDelegate,UICollectionViewDataSource
extension AnchorViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeView.anchorModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeCellID, for: indexPath) as! HomeViewCell
        homeCell.anchorModel = homeView.anchorModels[indexPath.item]
        return homeCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismissScreenListPlayView()
        let roomVc = RoomViewController()
        roomVc.anchorM = homeView.anchorModels[indexPath.item]
        navigationController?.pushViewController(roomVc, animated: true)
    }
}
