//
//  LaunchViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(Selector("startDaveoIdeaBoxApp"), withObject: nil, afterDelay: 1.5)
    }
    
    func startDaveoIdeaBoxApp() {
        performSegueWithIdentifier("startDaveoIdeaBoxApp", sender: nil)
    }

}
