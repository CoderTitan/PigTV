//
//  WebViewController.swift
//  GYJTV
//
//  Created by zcm_iOS on 2017/6/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    //MARK: 对外属性
    var webUrl : String = ""
    
    //MARK: 私有属性
    fileprivate lazy var webView : UIWebView = {
        let web = UIWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        loadRequest()
    }
}

//MARK: 界面处理
extension WebViewController{
    fileprivate func setupWebView(){
        navigationController?.navigationBar.tintColor = UIColor.white
        view.addSubview(webView)
    }
    
    fileprivate func loadRequest(){
        let request = URLRequest(url: URL(string: webUrl)!)
        webView.loadRequest(request)
    }
}
