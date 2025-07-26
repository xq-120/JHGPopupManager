//
//  XQHelloWorldAlertView.swift
//  JHPopupManagerDemo
//
//  Created by uzzi on 2025/7/11.
//

import UIKit

class XQHelloWorldAlertView: UIView, JHGPopupManagerItemProtocol {
    
    weak var inView: UIView?
    
    deinit {
        NSLog("==>dealloc")
    }
    
    func jh_show(animated: Bool, completion: (() -> Void)?) {
        if inView == nil {
            inView = JHGPopupUtils.appMainWindow()
        }
        inView?.addSubview(self)
        self.center = inView?.center ?? .zero
        
        self.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        } completion: { finish in
            completion?()
        }
    }
    
    func jh_hidden(animated: Bool, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { finished in
            self.removeFromSuperview()
            completion?()
        }

        NSLog("==>关闭弹窗：\(self.identifier)")
    }
    
    func jh_shouldPopup(in viewController: UIViewController?) -> Bool {
        return true
    }
    
    var textLabel: UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.6)
        self.addSubview(textLabel)
        textLabel.text = "任意自定义类型弹窗"
        textLabel.frame = CGRectMake(0, 0, 300, 300)
        textLabel.center = self.center
        textLabel.layer.cornerRadius = 8
        textLabel.textAlignment = .center
        textLabel.backgroundColor = .green
        textLabel.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onTapped(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func onTapped(_ sender: UIGestureRecognizer) {
        jh_hidden(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
