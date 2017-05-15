//
//  TQJPageView.swift
//  GYJTV
//
//  Created by 田全军 on 2017/5/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class TQJPageView: UIView {
    
    // MARK: 定义属性
    fileprivate var titles : [String]!
    fileprivate var style : TQJTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : TQJTitleView!
    fileprivate var contentView : TQJContentView!
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles : [String], style : TQJTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
        assert(titles.count == childVcs.count, "标题&控制器个数不同,请检测!!!")
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置界面内容
extension TQJPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = TQJTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = TQJContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}


// MARK:- 设置TQJContentView的代理
extension TQJPageView : TQJContentViewDelegate {
    func contentView(_ contentView: TQJContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: TQJContentView) {
        titleView.contentViewDidEndScroll()
    }
}


// MARK:- 设置TQJTitleView的代理
extension TQJPageView : TQJTitleViewDelegate {
    func titleView(_ titleView: TQJTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
