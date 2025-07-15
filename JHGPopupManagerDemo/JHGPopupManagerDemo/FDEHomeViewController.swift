//
//  ViewController.swift
//  DemonSwift
//
//  Created by uzzi on 2020/1/30.
//  Copyright © 2020 uzzi. All rights reserved.
//

import UIKit
import JHGPopupKit

class FDEHomeViewController: FDEBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var dataList: [FDEItemModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubview()
        loadData()
    }
    
    func setupSubview() {
        self.navigationItem.title = "首页"
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }

    func loadData() {
        dataList.removeAll()
        
        do {
            let item = FDEItemModel.init()
            item.title = "很多个弹窗"
            item.actionBlk = { [weak self] in
                self?.testManayAlert()
            }
            dataList.append(item)
        }
    }
    
    func testManayAlert() {
        let alert0 = XQHelloWorldAlertView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        JHGPopupManager.show(popupView: alert0, animated: true) {
            NSLog("XQHelloWorldAlertView弹出")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            JHGPopupManager.hidden(popupView: alert0, animated: true, completion: nil)
        })
        
        let alert1 = AuditionEndBuyAlertView.init()
        JHGPopupManager.show(popupView: alert1, animated: true) {
            NSLog("AuditionEndBuyAlertView弹出")
        }
        
        let alert2 = BroadcastBeginAlertView.init()
        JHGPopupManager.show(popupView: alert2, animated: true) {
            NSLog("BroadcastBeginAlertView弹出")
        }
        
        let alert3 = LoveKeyAlertPopupView.init()
        alert3.priority = 100
        JHGPopupManager.show(popupView: alert3, animated: true) {
            NSLog("LoveKeyAlertPopupView弹出")
        }
        
        let alert3_1 = JKPublishCommentAlertViewController.init()
        JHGPopupManager.show(popupView: alert3_1, animated: true) {
            NSLog("JKPublishCommentAlertViewController弹出")
        }
        
        let alert4 = SupportGroupVoteAlertView.init()
        JHGPopupManager.show(popupView: alert4, animated: true) {
            NSLog("SupportGroupVoteAlertView弹出")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataList[indexPath.row]
        item.actionBlk?()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { //13.0+不能设置为default
            return .darkContent
        } else {
            return .default
        }
    }
}

