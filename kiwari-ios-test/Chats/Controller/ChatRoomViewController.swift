//
//  ViewController.swift
//  kiwari-ios-test
//
//  Created by keenOI on 20/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController {

    var window: UIWindow?
    var tableView = UITableView()
    var bottomView = UIView()
    var chatTextfield = UITextField()
    var sendButton = UIButton(type: .system)
    var chatCell = "chatCell"
    var chatMessages = [Message]()
    var roomId = "-M5L9fjyzhA7_YsqiGof"
    var bottomContraint = NSLayoutConstraint()
    var iconImageView = UIImageView()
    var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    deinit { NotificationCenter.default.removeObserver(self) }
}
