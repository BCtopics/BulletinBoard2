//
//  AppDelegate.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 6/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound ]) { (isAuthorized, error) in
            
            if let error = error {
                NSLog("Permission Denied: \(error.localizedDescription)")
            }
            
            if isAuthorized {
                UIApplication.shared.registerForRemoteNotifications()
                NSLog("Permission Granted")
            }
            
        }
        
        return true
    }

}

