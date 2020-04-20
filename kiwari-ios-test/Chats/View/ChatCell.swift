//
//  ChatCell.swift
//  kiwari-ios-test
//
//  Created by keenOI on 20/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var chatView = UIView()
    var chatTextView = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func left() {
        addSubview(chatView)
        addSubview(chatTextView)
        addSubview(dateLabel)
        chatView.backgroundColor = #colorLiteral(red: 0.9340422085, green: 0.9340422085, blue: 0.9340422085, alpha: 1)
        chatView.layer.cornerRadius = 10
        chatView.translatesAutoresizingMaskIntoConstraints = false
        
        chatTextView.numberOfLines = 0
        chatTextView.font = UIFont(name: "helvetica", size: 16)
        chatTextView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.italicSystemFont(ofSize: 10)
        dateLabel.textAlignment = .left
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let contrains = [
            chatTextView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            chatTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            chatTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            chatTextView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            chatView.topAnchor.constraint(equalTo: chatTextView.topAnchor, constant: -10),
            chatView.leadingAnchor.constraint(equalTo: chatTextView.leadingAnchor, constant: -10),
            chatView.bottomAnchor.constraint(equalTo: chatTextView.bottomAnchor, constant: 10),
            chatView.trailingAnchor.constraint(equalTo: chatTextView.trailingAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: chatView.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(contrains)
    }
    
    func right() {
        addSubview(chatView)
        addSubview(chatTextView)
        addSubview(dateLabel)
        
        chatView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        chatView.layer.cornerRadius = 10
        chatView.translatesAutoresizingMaskIntoConstraints = false
        
        chatTextView.numberOfLines = 0
        chatTextView.textColor = .white
        chatTextView.font = UIFont(name: "helvetica", size: 16)
        chatTextView.textAlignment = .right
        chatTextView.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.italicSystemFont(ofSize: 10)
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let contrains = [
            chatTextView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            chatTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            chatTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chatTextView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            chatView.topAnchor.constraint(equalTo: chatTextView.topAnchor, constant: -10),
            chatView.leadingAnchor.constraint(equalTo: chatTextView.leadingAnchor, constant: -10),
            chatView.bottomAnchor.constraint(equalTo: chatTextView.bottomAnchor, constant: 10),
            chatView.trailingAnchor.constraint(equalTo: chatTextView.trailingAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: chatView.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(contrains)
    }
}
