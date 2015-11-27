//
//  NavigationViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Status bar white font
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.whiteColor()
        
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "showScreenSaverView", name: NotificationIdentifiers.screenSaverTimeUp, object: nil)
    }
    
    func showScreenSaverView() {
        performSegueWithIdentifier("showScreenSaverView", sender: nil)
    }
}
