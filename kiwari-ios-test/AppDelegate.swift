//
//  AppDelegate.swift
//  kiwari-ios-test
//
//  Created by keenOI on 20/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let chatRoom = ChatRoomViewController()
        window?.rootViewController = UINavigationController(rootViewController: chatRoom)
        
        return true
    }


}

