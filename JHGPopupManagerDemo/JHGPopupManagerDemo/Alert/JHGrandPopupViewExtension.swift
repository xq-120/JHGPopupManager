//
//  JHGrandPopupViewExtension.swift
//  JHPopupManagerDemo
//
//  Created by uzzi on 2025/6/26.
//

import Foundation
import JHGPopupManager
import JHGPopupKit //oc类

extension JHGPopupViewController: @retroactive JHGPopupViewProtocol {

    public func jh_show(animated: Bool, completion: (() -> Void)?) {
        if self.inViewController == nil {
            self.inViewController = JHGPopupUtils.topViewController()
        }
        self.show(in: self.inViewController, animated: animated, completion: completion)
    }
    
    public func jh_hidden(animated: Bool, completion: (() -> Void)?) {
        self.hiddenWith(animated: animated, completion: completion)
    }
    
    public func shouldPopup(in viewController: UIViewController?) -> Bool {
        return true
    }
}
