//
//  EmotionView.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/24.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kEmoticonCellID = "kEmoticonCellID"

class EmotionView: UIView {

    //闭包回调
    var emotionClickCallBack : ((EmotionModel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 创建collectionView
extension EmotionView{
    fileprivate func setupCollectionView(){
        // 1.创建PageCollectionView
        let style = TQJTitleStyle()
        style.isShowBottomLine = true
        let layout = TQJPageCollectionLayout()
        layout.cols = 7 // 列
        layout.rows = 3 // 行
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let pageCollection = TQJCollectionView(frame: bounds, style: style, titles: ["普通", "粉丝专属"], isTitleInTop: false, layout: layout)
        pageCollection.delegate = self
        pageCollection.dataSource = self
        addSubview(pageCollection)
        pageCollection.register(nib: UINib(nibName: "EmoticonViewCell", bundle: nil), identifier: kEmoticonCellID)
    }
}

//MARK: TQJCollectionViewDateSource
extension EmotionView : TQJCollectionViewDateSource{
    func numberOfSections(in pageCollectionView: TQJCollectionView) -> Int {
        return EmotionViewModel.shareInstance.emotionPackArray.count
    }
    func pageCollectionView(_ collectionView: TQJCollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmotionViewModel.shareInstance.emotionPackArray[section].emotionsArray.count
    }
    func pageCollectionView(_ pageCollectionView: TQJCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCellID, for: indexPath) as! EmoticonViewCell
        cell.emoticon = EmotionViewModel.shareInstance.emotionPackArray[indexPath.section].emotionsArray[indexPath.item]
        return cell
    }
}

//MARK: TQJCollectionViewDelegate
extension EmotionView : TQJCollectionViewDelegate{
    func pageCollectionView(_ pageCollectionView: TQJCollectionView, didSelectorItemAt indexPath: IndexPath) {
        let emotion = EmotionViewModel.shareInstance.emotionPackArray[indexPath.section].emotionsArray[indexPath.item]
        if let emotionClickCallBack = emotionClickCallBack {
            emotionClickCallBack(emotion)
        }
    }
}
