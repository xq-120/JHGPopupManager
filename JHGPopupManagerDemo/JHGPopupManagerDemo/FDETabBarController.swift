//
//  FDETabBarController.swift
//  DemonSwift
//
//  Created by uzzi on 2020/1/30.
//  Copyright © 2020 uzzi. All rights reserved.
//

import UIKit

class FDETabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupControllers()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black.withAlphaComponent(0.8)  // 👉 设置你要的背景色
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func setupControllers() {
        let homeVC = FDEHomeViewController.init()
        let homeNav = FDENavigationController.init(rootViewController: homeVC)
        homeNav.tabBarItem.title = "首页"
        
        let msgVC = FDEMessageViewController.init()
        let msgNav = FDENavigationController.init(rootViewController: msgVC)
        msgNav.tabBarItem.title = "消息"
        
        let mineVC = FDEMineViewController.init()
        let mineNav = FDENavigationController.init(rootViewController: mineVC)
        mineNav.tabBarItem.title = "我"
        
        let controllers = [homeNav, msgNav, mineNav]
        self.setViewControllers(controllers, animated: false)
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.selectedViewController
    }
}
