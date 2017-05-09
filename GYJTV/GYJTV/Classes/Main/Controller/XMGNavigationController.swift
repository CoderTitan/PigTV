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

        /*//1,运行时,打印手势的所有属性
        var count : UInt32 = 0
        let iVars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let nsmeP = ivar_getName(iVars[Int(i)])!
            let name = String(cString: nsmeP)
            print(name)
        }
 */
        
        guard let targets = interactivePopGestureRecognizer!.value(forKey: "_targets") as? [NSObject] else {
            return
        }
        let targetObject = targets[0]
        let target = targetObject.value(forKey: "target")
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
