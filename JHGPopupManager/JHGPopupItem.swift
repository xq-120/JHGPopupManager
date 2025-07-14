//
//  JHPopupItem.swift
//  JHPopupManager
//
//  Created by uzzi on 2025/6/12.
//

import Foundation

class JHGPopupItem {
    var popupView: JHGPopupViewProtocol
    
    var animated: Bool = true
    
    var isShowingInProgress: Bool = false
    
    var onShowCompletion: (()->Void)?
    
    init(popupView: JHGPopupViewProtocol) {
        self.popupView = popupView
    }
}
