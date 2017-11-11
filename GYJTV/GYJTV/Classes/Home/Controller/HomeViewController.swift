//
//  HomeViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
        setupContentView()
        setupVideoCaptionButton()
    }
    
    private func setupNavigationBar() {
        title = "首页"
        
        // 1.左侧logoItem
        let logoImage = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        // 2.设置右侧收藏的item
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(followItemClick))
    }
    
    fileprivate func setupContentView(){
        //获取数据
        let homeTypes = loadTitleData()
        
        let style = TQJTitleStyle()
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenWidth, height: kScreenHeight - kNavigationBarH - kStatusBarH - kTabBarH)
        let titles = homeTypes.map({ $0.title })
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVc = AnchorViewController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        let pageView = TQJPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTitleData() -> [HomeType]{
        let pathStr = Bundle.main.path(forResource: "types", ofType: "plist")!
        let dataArray = NSArray(contentsOfFile: pathStr) as! [[String : Any]]
        var tempArray = [HomeType]()
        for dic in dataArray {
            tempArray.append(HomeType(dic: dic))
        }
        return tempArray
    }
    
    //添加视频采集入口
    fileprivate func setupVideoCaptionButton(){
        let backImage = UIImageView(frame: CGRect(x: kScreenWidth - 65, y: kScreenHeight - 115, width: 50, height: 50))
        backImage.image = UIImage(named: "live_open")
        backImage.isUserInteractionEnabled = true
        backImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(videoButtonClick)))
        view.addSubview(backImage)
    }
}

// MARK:- 事件监听函数
extension HomeViewController {
    @objc fileprivate func followItemClick() {
        let foucus = FocusViewController()
        foucus.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(foucus, animated: true)
    }
    
    @objc fileprivate func videoButtonClick(){
        let shade = ShadeView(frame: UIScreen.main.bounds)
        shade.delegate = self
        shade.showShadeView()
    }
}

//MARK: ShadeViewDelegate
extension HomeViewController : ShadeViewDelegate{
    func shadeViewDidSelector(_ shadeView: ShadeView) {
        present(LivingViewController(), animated: true, completion: nil)
    }
}

