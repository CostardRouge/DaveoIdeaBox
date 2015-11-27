//
//  AppDelegate.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

struct NotificationIdentifiers {
    static let screenSaverTimeUp = "screenSaverTimeUpNotification"
    static let userActivity = "userActivityNotification"
}

struct ScreenSaverSettings {
    static let timeBeforeActivation = 10.0
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var screenSaverTimer: NSTimer?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setScreenSaverTimer()
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "setScreenSaverTimer", name: NotificationIdentifiers.userActivity, object: nil)
        
        return true
    }
    
    func applicationWillTerminate(application: UIApplication) {
        EntryManager.sharedInstance.persistEntries()
    }
    
    func showAppScreenSaver() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(NotificationIdentifiers.screenSaverTimeUp, object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        setScreenSaverTimer()
    }
    
    func setScreenSaverTimer() {
        screenSaverTimer = screenSaverTimer ?? NSTimer()
        
        screenSaverTimer?.invalidate()
        screenSaverTimer = NSTimer.scheduledTimerWithTimeInterval(ScreenSaverSettings.timeBeforeActivation, target: self, selector: "showAppScreenSaver", userInfo: nil, repeats: false)
    }
    
    static func postUserActivityNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(NotificationIdentifiers.userActivity, object: nil)
    }
}