//
//  ScreenSaverViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class ScreenSaverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}
