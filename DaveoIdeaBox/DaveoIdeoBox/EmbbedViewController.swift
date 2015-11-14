//
//  EmbbedViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class EmbbedViewController: UIViewController {
    
    @IBOutlet weak var addIdeaView: UIView!
    @IBOutlet weak var contributeView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addIdeaButtonTouchUpInside(sender: UIButton) {
        print("addIdeaButtonTouchUpInside")
        //performSegueWithIdentifier("addIdeaView", sender: nil)
    }
    
    @IBAction func handleSingleTap(recognizer: UITapGestureRecognizer) {
        print("handleSingleTap")
        performSegueWithIdentifier("submitEntryView", sender: nil)
    }
}
