//
//  TQJPageCollectionLayout.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/16.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class TQJPageCollectionLayout: UICollectionViewFlowLayout {
    
    var cols : Int = 4 //列
    var rows : Int = 2 //行
    
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxWidth : CGFloat = 0

}

extension TQJPageCollectionLayout{
//    在该方法中设定一些必要的layout的结构和初始需要的参数
    override func prepare() {
        super.prepare()
        
        //0.计算item的宽度和高度
        let itemW = ((collectionView?.bounds.width)! - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = ((collectionView?.bounds.height)! - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        
        //1.获取一共多少个组
        let sectionCount = collectionView!.numberOfSections
        
        //2.获取每个组中有多少个item
        var prePageCount : Int = 0    //页数
        for i in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: i)
            for j in 0..<itemCount {
                //2.1获取cell对应的indexPath
                let indexpath = IndexPath(item: j, section: i)
                //2.2根据indexPath创建UICollectionViewLayoutAttributes
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexpath)
                // 2.3.计算j在该组中第几页
                let page = j / (cols * rows)
                let index = j % (cols * rows)
                //2.4设置attrs的frame
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                let itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width +  sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                //2.5加入到数组中
                cellAttrs.append(attr)
            }
            prePageCount += (itemCount - 1) / (cols * rows) + 1
        }
        //计算最大宽度
        maxWidth = CGFloat(prePageCount) * collectionView!.bounds.width
    }
}

extension TQJPageCollectionLayout{
    //返回rect中的所有的元素的布局属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
    //确定collectionView的所有内容的尺寸
    override var collectionViewContentSize: CGSize{
        return CGSize(width: maxWidth, height: 0)
    }
}

