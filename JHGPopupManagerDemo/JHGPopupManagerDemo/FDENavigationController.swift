//
//  FDENavigationController.swift
//  DemonSwift
//
//  Created by uzzi on 2020/1/30.
//  Copyright © 2020 uzzi. All rights reserved.
//

import UIKit

class FDENavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 根控制器不隐藏 tabbar，其它都隐藏
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
