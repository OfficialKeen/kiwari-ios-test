//
//  ChatRoomViewController+Extention.swift
//  kiwari-ios-test
//
//  Created by keenOI on 21/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit
import Firebase

extension ChatRoomViewController {
    func bindData() {
        checkLogin()
        bindUI()
        setRegister1()
        setAnchorMain1()
        setAnchotUI()
        setupAnchorViewBar()
        handleKeyboard()
        setNavigation()
    }
}

extension ChatRoomViewController {
    fileprivate func bindUI() {
        view.backgroundColor = .white
        bottomView.setObjectView {_ in
            bottomView.backgroundColor = .lightGray
        }
        
        chatTextfield.setObject {_ in
            chatTextfield.placeholder = "chat here..."
        }
        
        sendButton.setObject {_ in
            sendButton.setTitle("Send", for: .normal)
            sendButton.addTarget(self, action: #selector(handleSendChat), for: .touchUpInside)
        }
        
        iconImageView.setObject {_ in
            iconImageView.contentMode = .scaleAspectFit
        }
        
        titleLabel.setObject {_ in
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = UIColor.black
        }
    }
    
    func setupAnchorViewBar() {
        self.navigationController?.navigationBar.addSubview(iconImageView)
        self.navigationController?.navigationBar.addSubview(titleLabel)
        
        iconImageView.setAnchor(top: self.navigationController?.navigationBar.topAnchor, left: self.navigationController?.navigationBar.leftAnchor, bottom: self.navigationController?.navigationBar.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        titleLabel.setAnchor(top: self.navigationController?.navigationBar.topAnchor, left: iconImageView.rightAnchor, bottom: self.navigationController?.navigationBar.bottomAnchor, right: self.navigationController?.navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 10)
        
    }
    
    fileprivate func setRegister1() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ChatCell.self, forCellReuseIdentifier: chatCell)
    }
    
    fileprivate func setAnchorMain1() {
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        view.addSubview(bottomView)
        bottomView.setAnchor(top: tableView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .zero, height: 50)
    }
    
    fileprivate func setAnchotUI() {
        bottomView.addSubview(chatTextfield)
        chatTextfield.setAnchor(top: bottomView.topAnchor, left: bottomView.leftAnchor, bottom: bottomView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        bottomView.addSubview(sendButton)
        sendButton.setAnchor(top: bottomView.topAnchor, left: chatTextfield.rightAnchor, bottom: bottomView.bottomAnchor, right: bottomView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
    }
}

extension ChatRoomViewController {
    @objc func handleSendChat() {
        guard let chatText = self.chatTextfield.text, chatText.isEmpty == false else {
            return
        }
        
        sendMessage(chatText) { (isSuccess) in
            if (isSuccess) {
                
            }
        }
    }
    
    func sendMessage(_ chatText: String, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let databaseRef = Database.database().reference()
        getUsernameWithId(id: userId) { (userName) in
            if let userName = userName, let userId = Auth.auth().currentUser?.uid {
                let dataArray: [String: Any] = [
                    "senderId": userId,
                    "senderName": userName,
                    "text": chatText,
                    "time": Date().timeIntervalSince1970
                    
                ]
                
                let room = databaseRef.child("rooms").child(self.roomId)
                room.child("messages").childByAutoId().setValue(dataArray) { (error, ref) in
                    if (error == nil) {
                        completion(true)
                        self.chatTextfield.text = ""
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func getUsernameWithId(id: String, completion: @escaping (_ userName: String?) -> ()) {
        let databaseRef = Database.database().reference()
        let user = databaseRef.child("users").child(id)
        
        user.child("name").observeSingleEvent(of: .value) { (snapshot) in
            if let userName = snapshot.value as? String {
                completion(userName)
            } else {
                completion(nil)
            }
        }
    }
    
    func observerMessage() {
        let databaseRef = Database.database().reference()
        databaseRef.child("rooms").child(roomId).child("messages").observe(.childAdded) { (snapshot) in
            if let dataArray = snapshot.value as? [String: Any] {
                guard
                    let senderName = dataArray["senderName"] as? String,
                    let messageText = dataArray["text"] as? String,
                    let time = dataArray["time"] as? Double,
                    let userId = dataArray["senderId"] as? String else {
                        return
                }
                let message = Message.init(messageKey: snapshot.key, senderName: senderName, messageText: messageText, userId: userId, time: time)
                self.chatMessages.append(message)
                self.tableView.reloadData()
                self.lastMessage()
            }
        }
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatMessages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCell, for: indexPath) as! ChatCell
        cell.chatTextView.text = message.messageText
        
        if (message.userId == Auth.auth().currentUser!.uid) {
            cell.right()
        } else {
            cell.left()
        }
        
        let timeStamp = message.time!
        let lastTime = Date(timeIntervalSince1970: timeStamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, H:mm"
        cell.dateLabel.text = formatter.string(from: lastTime)
        return cell
    }
}

extension ChatRoomViewController {
    fileprivate func setNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:false)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        
        if let imgLogout = UIImage(named: "logout") {
            imageView.image = imgLogout
        }
        view.addSubview(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(handleLogout))
        view.addGestureRecognizer(backTap)
        
        let rightBarButtonItem = UIBarButtonItem(customView: view )
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setNav() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                var user = User()
                user.id = snapshot.key
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.image = dictionary["profileImage"] as? String
                let currentUserID : String = (Auth.auth().currentUser?.uid)!
                if user.id != currentUserID {
                    self.view.backgroundColor = .white
                    self.titleLabel.text = user.name
                    if let imageURL = URL(string: user.image!) {
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: imageURL)
                            if let data = data {
                                let image = UIImage(data: data)
                                DispatchQueue.main.async {
                                    self.iconImageView.image = image
                                }
                            }
                        }
                    }
                }
            }
            
        }, withCancel: nil)
    }
}

extension ChatRoomViewController {
    fileprivate func handleKeyboard() {
        hideKeyboardWhenTappedComments()
        bottomContraint = NSLayoutConstraint(item: bottomView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomContraint)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomContraint.constant = isKeyboardShowing ? -keyboardSize.height : 0
            self.lastMessage()
        }
    }
    
    func hideKeyboardWhenTappedComments() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func lastMessage() {
        let lastVisibleCell = self.tableView.indexPathsForVisibleRows?.last
        UIView.animate( withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
            if let lastVisibleCell = lastVisibleCell {
                self.tableView.scrollToRow(
                    at: lastVisibleCell,
                    at: .bottom,
                    animated: false)
            }
        })
    }
}

extension ChatRoomViewController {
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.titleLabel.text = ""
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let sigInViewController = SigInViewController()
        navigationController?.pushViewController(sigInViewController, animated: true)
    }
    
    @objc func handleLogout() {
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in",         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            self.logOut()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ChatRoomViewController {
    func checkLogin() {
        CustomActivityIndicator.shared.show(uiView: self.view, backgroundColor: .lightGray)
        let uid = Auth.auth().currentUser?.uid
        if uid == nil {
            let sigInViewController = SigInViewController()
            navigationController?.pushViewController(sigInViewController, animated: true)
        } else {
            Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                self.observerMessage()
                self.setNav()
                CustomActivityIndicator.shared.hide(uiView: (self.view)!)
            }, withCancel: nil)
        }
    }
}
