//
//  SubRankViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/21.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class SubRankViewController: UIViewController {

    fileprivate var typeName : String = ""
    var currentIndex : Int = 0 {
        didSet{
            switch currentIndex {
            case 0:
                typeName = "rankStar"
            case 1:
                typeName = "rankWealth"
            case 2:
                typeName = "rankPopularity"
            case 3:
                typeName = "rankAll"
            default:
                print("错误类型")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//MARK: 添加子控制器
extension SubRankViewController{
    func setupSubrankControllers( _ titles : [String]){
        let pageRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64 - 44)
        let style = TQJTitleStyle()
        style.isScrollEnable = false
        style.titleBackGroundColor = UIColor.white
        style.titleHeight = 35
        var childVCArr = [DetailRankViewController]()
        for i in 0..<titles.count {
            let rankType = RankType(typeName: typeName, typeNum: i + 1)
            let vc = currentIndex == 3 ? WeeklyRankViewController(rankType: rankType) : DetailRankViewController(rankType: rankType)
            childVCArr.append(vc)
        }
        
        let pageView = TQJPageView(frame: pageRect, titles: titles, style: style, childVcs: childVCArr, parentVc: self)
        view.addSubview(pageView)
    }
}
