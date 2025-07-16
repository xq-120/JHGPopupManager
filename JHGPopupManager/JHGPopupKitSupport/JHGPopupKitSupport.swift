//
//  JHGPopupKitSupport.swift
//  JHGPopupManager
//
//  Created by uzzi on 2025/7/16.
//

import Foundation

#if canImport(JHGPopupKit)
import JHGPopupKit

extension JHGPopupView: JHGPopupManagerItemProtocol {
    open func jh_show(animated: Bool, completion: (() -> Void)?) {
        self.showWith(animated: animated, completion: completion)
    }
    
    open func jh_hidden(animated: Bool, completion: (() -> Void)?) {
        self.hiddenWith(animated: animated, completion: completion)
    }
    
    open func jh_shouldPopup(in viewController: UIViewController?) -> Bool {
        return true
    }
}

extension JHGPopupViewController: JHGPopupManagerItemProtocol {
    open func jh_show(animated: Bool, completion: (() -> Void)?) {
        self.showWith(animated: animated, completion: completion)
    }
    
    open func jh_hidden(animated: Bool, completion: (() -> Void)?) {
        self.hiddenWith(animated: animated, completion: completion)
    }
    
    open func jh_shouldPopup(in viewController: UIViewController?) -> Bool {
        return true
    }
}

#endif
