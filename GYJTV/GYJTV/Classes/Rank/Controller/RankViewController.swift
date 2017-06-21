//
//  RankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.

import UIKit

class RankViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pageRect = CGRect(x: 0, y: 20, width: kScreenWidth, height: kScreenHeight - 20)
        let titles = ["明星榜", "富豪榜", "人气榜", "周星榜"]
        let style = TQJTitleStyle()
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        style.isScrollEnable = false
        style.isShowBottomLine = true

        var childvcArr = [SubRankViewController]()
        for i in 0..<titles.count {
            let vc = i == 3 ? WeekAllRankViewController() : NormalRankViewController()
            vc.currentIndex = i
            childvcArr.append(vc)
        }
        
        let pageView = TQJPageView(frame: pageRect, titles: titles, style: style, childVcs: childvcArr, parentVc: self)
        view.addSubview(pageView)
    }
}
