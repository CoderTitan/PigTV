//
//  TQJCollectionView.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

protocol TQJCollectionViewDateSource : class {
    
    func numberOfSections(in pageCollectionView : TQJCollectionView) -> Int
    func pageCollectionView(_ collectionView : TQJCollectionView, numberOfItemsInSection section : Int) -> Int
    func pageCollectionView(_ pageCollectionView : TQJCollectionView, _ collectionView : UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell
    
}
protocol TQJCollectionViewDelegate : class {
    func pageCollectionView(_ pageCollectionView : TQJCollectionView, didSelectorItemAt indexPath : IndexPath)
}

private let kCollectionViewCell = "kCollectionViewCell"
class TQJCollectionView: UIView {

    // MARK: 代理
    weak var dataSource : TQJCollectionViewDateSource?
    weak var delegate : TQJCollectionViewDelegate?
    // MARK: 页面属性
    fileprivate var style : TQJTitleStyle
    fileprivate var titles : [String]
    fileprivate var isTitleInTop : Bool
    fileprivate var layout : TQJPageCollectionLayout
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var titleView : TQJTitleView!
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect, style : TQJTitleStyle, titles : [String], isTitleInTop : Bool, layout : TQJPageCollectionLayout) {
        self.style = style
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 界面搭建
extension TQJCollectionView{
    fileprivate func setupUI(){
        //1.创建titleView
        let titleViewY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        titleView = TQJTitleView(frame: CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight), titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)
        
        //2.创建pageControl
        let pageControllHeight : CGFloat = 20
        let pageControlY = isTitleInTop ? bounds.height - pageControllHeight : bounds.height - pageControllHeight - style.titleHeight
        pageControl = UIPageControl(frame: CGRect(x: 0, y: pageControlY , width: bounds.width, height: pageControllHeight))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        addSubview(pageControl)

        //3.创建collectionView
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: bounds.width, height: bounds.height - style.titleHeight - pageControllHeight), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCell)
        addSubview(collectionView)
        pageControl.backgroundColor = collectionView.backgroundColor
    }
}

// MARK: 对外暴露的方法
extension TQJCollectionView{
    func register(cell : AnyClass?, identifier : String) {
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }
    func register(nib : UINib, identifier : String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension TQJCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.rows) + 1
        }
        return itemCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}

// MARK: UICollectionVIewDelegate
extension TQJCollectionView : UICollectionViewDelegate{
    //结束减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    //结束滑动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewEndScroll()
    }
    
    fileprivate func scrollViewEndScroll(){
        //取出在屏幕中显示的cell
        let point = CGPoint(x: layout.sectionInset.left + collectionView.contentOffset.x + 1, y: layout.sectionInset.top + 1)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        //判断分组是否发生改变
        if sourceIndexPath.section != indexPath.section {
            //修改pageController的个数
            let itemCOunt = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCOunt - 1) / (layout.cols * layout.rows) + 1
            //设置titleView的位置
            titleView.setTitleWithProgress(1.0, sourceIndex: sourceIndexPath.section, targetIndex: indexPath.section)
            //记录
            sourceIndexPath = indexPath
        }
        // 3.根据indexPath设置pageControl
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView(self, didSelectorItemAt: indexPath)
    }
}

// MARK: TQJTitleViewDelegate
extension TQJCollectionView : TQJTitleViewDelegate{
    func titleView(_ titleView: TQJTitleView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        //此处若为true,则会重新调用EndDecelerating和EndDragging方法
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        scrollViewEndScroll()
    }
}
