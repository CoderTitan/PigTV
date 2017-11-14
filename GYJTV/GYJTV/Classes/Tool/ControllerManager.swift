//
//  ControllerManager.swift
//  GYJTV
//
//  Created by 田全军 on 17/10/2
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import Foundation
import UIKit

class ControllerManager {
    
    static var tabbarController: MainViewController?
    
    static func openWebWithURL(url: String) {
        guard let urlString = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(urlString) {
            UIApplication.shared.open(urlString)
        }
    }
    
    static func pushToController(controller: UIViewController, animated: Bool = true) {
        guard let tabController = self.getTabbarController() else { return }
        controller.hidesBottomBarWhenPushed = true
        tabController.selectedViewController?.childViewControllers.last?.navigationController?.popToRootViewController(animated: animated)
        tabController.selectedViewController?.childViewControllers.last?.navigationController?.pushViewController(controller, animated: animated)
    }
    
    static func pushToController(controller: UIViewController, baseController: UIViewController, shouldEnable3DTouch enable3DTouch: Bool = false, animated: Bool = true) {
        controller.hidesBottomBarWhenPushed = true
        baseController.navigationController?.pushViewController(controller, animated: animated)
    }
    
    static func presentController(controller: UIViewController, withTitle title: String = "", animated: Bool = true) {
        guard let tabController = self.getTabbarController() else { return }
        controller.hidesBottomBarWhenPushed = true
        let na = UINavigationController(rootViewController: controller)
        if !title.isEmpty { na.navigationItem.title = title }
        tabController.present(na, animated: animated, completion: nil)
    }
    
    static func presentController(controller: UIViewController, baseController: UIViewController, withTitle title: String = "", animated: Bool = true) {
        controller.hidesBottomBarWhenPushed = true
        let na = UINavigationController(rootViewController: controller)
        if !title.isEmpty { na.navigationItem.title = title }
        baseController.present(na, animated: animated, completion: nil)
    }
    
    static var visibleViewController: UIViewController? {
        guard var window = UIApplication.shared.keyWindow else { return nil }
        if window.windowLevel != UIWindowLevelNormal {
            for tempWindow in UIApplication.shared.windows where tempWindow.windowLevel == UIWindowLevelNormal {
                window = tempWindow
                break
            }
        }
        return getVisibleViewControllerFrom(vc: window.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let vc = vc as? UINavigationController {
            return getVisibleViewControllerFrom(vc: vc.visibleViewController)
        } else if let vc = vc as? UITabBarController {
            return getVisibleViewControllerFrom(vc: vc.selectedViewController)
        } else if let vc = vc?.presentedViewController {
            return getVisibleViewControllerFrom(vc: vc)
        } else {
            return vc
        }
    }
    
    static func getTabbarController() -> MainViewController? {
        if tabbarController != nil { return tabbarController }
        guard var window = UIApplication.shared.keyWindow else { return nil }
        if window.windowLevel != UIWindowLevelNormal {
            for temp in UIApplication.shared.windows {
                if temp.windowLevel == UIWindowLevelAlert {
                    window = temp
                    break
                }
            }
        }
        guard let frontView = window.subviews.last else { return nil }
        if let nextResponder = frontView.next as? MainViewController {
            tabbarController = nextResponder
            return nextResponder
        } else {
            guard let root = window.rootViewController as? MainViewController else { return nil }
            tabbarController = root
            return root
        }
    }
}
