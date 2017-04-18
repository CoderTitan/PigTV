//
//  XMGNavigationController.swift
//  XMGTV
//
//  Created by 小码哥 on 2016/12/4.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class XMGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
