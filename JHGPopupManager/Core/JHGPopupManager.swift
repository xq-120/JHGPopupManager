//
//  JHPopupManager.swift
//  JHPopupManagerDemo
//
//  Created by uzzi on 2025/6/11.
//

import UIKit
import JHGPopupKit

public class JHGPopupManager {
    
    public static let manager = JHGPopupManager.init()
    
    public private(set) var isSuspend = false
    
    private var popupItems: [JHGPopupElement] = []
    
    private var curPopupItem: JHGPopupElement?
    
    private init() {
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0) { [weak self] ob, activity in
            guard let self = self else {return}
            self.handleRunLoopActivity(activity: activity)
        }
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .defaultMode)
    }
    
    func handleRunLoopActivity(activity: CFRunLoopActivity) {
        switch activity {
        case .entry:
            break;
        case .beforeTimers:
            break;
        case .beforeSources:
            break;
        case .beforeWaiting:
            dequeue()
        case .afterWaiting:
            break;
        case .exit:
            break;
        default:
            break;
        }
    }
    
    /// 弹出弹窗。弹窗将按顺序弹出。如果弹窗在排队中则不会马上弹出。
    /// - Parameters:
    ///   - popupView: 弹窗
    ///   - animated: 是否动画
    ///   - completion: 弹窗弹出完成时的回调。
    static public func show(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        let item = JHGPopupElement.init(popupView: popupView)
        item.animated = animated
        item.onShowCompletion = completion
        JHGPopupManager.manager.enqueue(item)
    }
    
    /// 关闭弹窗。如果弹窗还未被弹出，则直接从队列中移除。
    /// - Parameters:
    ///   - popupView: 弹窗
    ///   - animated: 是否动画
    ///   - completion: 弹窗关闭完成时的回调。
    static public func hidden(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        JHGPopupManager.manager.hidden(popupView: popupView, animated: animated, completion: completion)
    }
    
    /// 根据id移除弹窗。已经弹出的弹窗也将被关闭。
    /// - Parameter identifier: 弹窗ID。
    public func removePopupViews(with identifier: String) {
        popupItems.removeAll(where: {$0.popupView.identifier == identifier})
        if let cur = curPopupItem?.popupView, cur.identifier == identifier {
            cur.jh_hidden(animated: true, completion: nil)
        }
    }
    
    /// 暂停弹出
    public func suspend() {
        isSuspend = true
    }
    
    /// 恢复弹出
    public func resume() {
        isSuspend = false
        dequeue()
    }
    
    func hidden(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        if curPopupItem?.popupView === popupView {
            popupView.jh_hidden(animated: animated, completion: completion)
            curPopupItem = nil
        } else {
            remove(popupView)
            completion?()
        }
    }
    
    func remove(_ popupView: JHGPopupManagerItemProtocol) {
        if let index = popupItems.firstIndex(where: {$0.popupView === popupView}) {
            popupItems.remove(at: index)
        }
    }
    
    func enqueue(_ item: JHGPopupElement) {
        popupItems.append(item)
        popupItems.sort(by: {$0.popupView.priority > $1.popupView.priority})
        dequeue()
    }
    
    func dequeue() {
        if isSuspend || isPopupShowing() {
            return
        }
        curPopupItem = nil
        
        var poppingItemIndex: Int? = nil
        for (index, item) in popupItems.enumerated() {
            if callShouldPopup(popup: item.popupView) {
                poppingItemIndex = index
                break
            }
        }
        guard let index = poppingItemIndex else { return }
        
        let item = popupItems.remove(at: index)
        show(item)
    }
    
    func isPopupShowing() -> Bool {
        guard let curPopupItem = curPopupItem else { return false }
        if curPopupItem.isShowingInProgress || callIsShowing(popup: curPopupItem.popupView) {
            return true
        }
        return false
    }
    
    func show(_ item: JHGPopupElement) {
        assert(Thread.isMainThread)
        curPopupItem = item
        item.isShowingInProgress = true
        item.popupView.jh_show(animated: item.animated) {
            item.onShowCompletion?()
            item.isShowingInProgress = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if item.isShowingInProgress {
                item.isShowingInProgress = false
            }
        })
    }
    
    //MARK: - 工具方法
    func callIsShowing(popup: JHGPopupManagerItemProtocol) -> Bool {
        let sel = #selector(getter: JHGPopupManagerItemProtocol.isShowing)
        if popup.responds(to: sel), let ret = popup.isShowing {
            return ret
        }
        return popup.isShowing
    }
    
    func callIdentifier(popup: JHGPopupManagerItemProtocol) -> String {
        let sel = #selector(getter: JHGPopupManagerItemProtocol.identifier)
        if popup.responds(to: sel), let ret = popup.identifier {
            return ret
        }
        return popup.identifier
    }
    
    func callPriority(popup: JHGPopupManagerItemProtocol) -> Int {
        let sel = #selector(getter: JHGPopupManagerItemProtocol.priority)
        if popup.responds(to: sel), let ret = popup.priority {
            return ret
        }
        return popup.priority
    }
    
    func callShouldPopup(popup: JHGPopupManagerItemProtocol) -> Bool {
        let curTopVC = JHGPopupUtils.topViewController()
        if popup.responds(to: #selector(JHGPopupManagerItemProtocol.jh_shouldPopup(in:))), let ret =  popup.jh_shouldPopup?(in: curTopVC){
            return ret
        }
        return popup.jh_shouldPopup(in: curTopVC)
    }
}


