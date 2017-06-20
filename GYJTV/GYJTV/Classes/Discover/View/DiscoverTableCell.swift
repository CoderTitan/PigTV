//
//  DiscoverTableCell.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

fileprivate let kCollectionCell : String = "collectionCell"

//MARK: 点击事件代理

class DiscoverTableCell: UITableViewCell {

    fileprivate lazy var discoverVM : DiscoverViewModel = DiscoverViewModel()
    fileprivate var anchorArray : [AnchorModel]?
    fileprivate var currentIndex : Int = 0
    var cellDidSelected : ((_ anchorModel : AnchorModel) -> ())?
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = DiscoverContentLayout()
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collection.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        collection.register(UINib(nibName: "DiscoverCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCollectionCell)
        return collection
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        loadContentData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 界面处理
extension DiscoverTableCell{
    fileprivate func setupViews(){
        contentView.addSubview(collectionView)
    }
    
    func loadContentData(){
        discoverVM.loadDiscoverContentData {
            let count = self.discoverVM.anchorModels.count >= 9 ? 9 : self.discoverVM.anchorModels.count
            self.anchorArray = Array(self.discoverVM.anchorModels[self.currentIndex * 9..<count])
            self.collectionView.reloadData()
        }
    }

    //对外刷新方法
    func refreNextPageData(){
        currentIndex += 1
        let index = discoverVM.anchorModels.count % 9 == 0 ? discoverVM.anchorModels.count / 9 : discoverVM.anchorModels.count / 9 + 1
        if currentIndex >= index {
            currentIndex = 0
        }
        if discoverVM.anchorModels.count <= 0 {
            return
        }
        //取值的最大范围
        let count = currentIndex == index - 1 ? discoverVM.anchorModels.count : (currentIndex + 1) * 9
        anchorArray = Array(discoverVM.anchorModels[currentIndex * 9..<count])
        collectionView.reloadData()
    }
}

//MARK: collection代理
extension DiscoverTableCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! DiscoverCollectionCell
        cell.anchor = anchorArray?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellDidSelected = cellDidSelected {
            cellDidSelected(anchorArray![indexPath.item])
        }
    }
}

class DiscoverContentLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemMagin : CGFloat = 10
        let itemWidth : CGFloat = (collectionView!.frame.width - 5 * itemMagin) / 3
        let itemHeight : CGFloat = collectionView!.frame.height / 3
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        sectionInset = UIEdgeInsets(top: 0, left: itemMagin, bottom: 0, right: itemMagin)
        minimumLineSpacing = 0
        minimumInteritemSpacing = itemMagin
        collectionView?.bounces = false
    }
}
