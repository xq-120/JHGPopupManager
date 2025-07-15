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
//            NSLog("activity-->entry")
            break;
        case .beforeTimers:
//            NSLog("activity-->beforeTimers")
            break;
        case .beforeSources:
//            NSLog("activity-->beforeSources")
            break;
        case .beforeWaiting:
//            NSLog("activity-->beforeWaiting")
            dequeue()
        case .afterWaiting:
//            NSLog("activity-->afterWaiting")
            break;
        case .exit:
//            NSLog("activity-->exit")
            break;
        default:
            break;
        }
    }
    
    static public func show(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        let item = JHGPopupElement.init(popupView: popupView)
        item.animated = animated
        item.onShowCompletion = completion
        JHGPopupManager.manager.enqueue(item)
    }
    
    static public func hidden(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        JHGPopupManager.manager.hidden(popupView: popupView, animated: animated, completion: completion)
    }
    
    func hidden(popupView: JHGPopupManagerItemProtocol, animated: Bool, completion: (() -> Void)?) {
        if curPopupItem?.popupView === popupView {
            popupView.jh_hidden(animated: animated, completion: completion)
            curPopupItem = nil
        } else {
            remove(popupView)
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
    
    func isShowing() -> Bool {
        guard let curPopupItem = curPopupItem else { return false }
        if curPopupItem.isShowingInProgress || curPopupItem.popupView.isShowing {
            return true
        }
        return false
    }
    
    func dequeue() {
        if isShowing() {
            return
        }
        curPopupItem = nil
        
        var poppingItemIndex: Int? = nil
        for (index, item) in popupItems.enumerated() {
            if item.popupView.jh_shouldPopup(in: JHGPopupUtils.topViewController()) {
                poppingItemIndex = index
                break
            }
        }
        guard let index = poppingItemIndex else { return }
        
        let item = popupItems.remove(at: index)
        show(item)
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
    
    
}


