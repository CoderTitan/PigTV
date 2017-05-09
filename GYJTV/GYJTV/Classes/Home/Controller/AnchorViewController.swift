//
//  AnchorViewController.swift
//  GYJTV
//
//  Created by 田全军 on 2017/4/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

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
//        collection.backgroundColor = UIColor.yellow
        collection.register(UINib.init(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kHomeCellID)
        return collection
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        loadDataWithIndex(index: 0)
    }
}

// MARK: 设置界面和数据
extension AnchorViewController{
    fileprivate func setupViews(){
        view.addSubview(collectionView)
    }
    
    fileprivate func loadDataWithIndex(index : Int) {
        homeView.loadHomeData(type: homeType, index : index, finishedCallback: {
            self.collectionView.reloadData()
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
        if indexPath.item == homeView.anchorModels.count - 1 {
            loadDataWithIndex(index: homeView.anchorModels.count)
        }
        return homeCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        navigationController?.pushViewController(roomVc, animated: true)
    }
}
