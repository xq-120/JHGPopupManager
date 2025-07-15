//
//  JHGPopupElement.swift
//  JHPopupManager
//
//  Created by uzzi on 2025/6/12.
//

import Foundation

class JHGPopupElement {
    var popupView: JHGPopupManagerItemProtocol
    
    var animated: Bool = true
    
    var isShowingInProgress: Bool = false
    
    var onShowCompletion: (()->Void)?
    
    init(popupView: JHGPopupManagerItemProtocol) {
        self.popupView = popupView
    }
}
