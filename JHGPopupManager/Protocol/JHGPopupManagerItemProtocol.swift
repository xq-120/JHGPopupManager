//
//  JHPopupViewProtocol.swift
//  JHPopupManager
//
//  Created by uzzi on 2025/6/11.
//

import Foundation

@objc public protocol JHGPopupManagerItemProtocol: NSObjectProtocol {
    
    @objc var isShowing: Bool { get }
    
    @objc var identifier: String { get }
    
    /// 优先级默认0，数值越大优先级越高
    @objc var priority: Int { get }
    
    /// 弹出弹窗
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 弹窗弹出完成回调。
    @objc func jh_show(animated: Bool, completion: (() -> Void)?)
    
    /// 关闭弹窗
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 弹窗关闭完成回调。
    @objc func jh_hidden(animated: Bool, completion: (() -> Void)?)
    
    @objc func jh_shouldPopup(in viewController: UIViewController?) -> Bool
}


