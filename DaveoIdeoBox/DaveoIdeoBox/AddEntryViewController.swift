//
//  ModalViewController.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    // GUI elements
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    // Attributes
    var entry = Idea()
    
    override func viewDidLoad() {
        closeButton?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
    }
    
    @IBAction func submitEntryButtonTouchUpInside(sender: UIButton) {
        print("submitEntryButtonTouchUpInside")
        if isViewLoaded() {
            let emptyFields = nameTextField.text?.isEmpty == true || emailAdressTextField.text?.isEmpty == true || contentTextView.text?.isEmpty == true
            
            if emptyFields {
                let alert = UIAlertController(title: "Allô Houston ?!", message: "Il manque quelque chose", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Oops, c'est de ma faute", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        //UIApplication.sharedApplication().statusBarStyle = .LightContent
            
        //.setStatusBarStyle(.LightContent, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //UIApplication.sharedApplication().statusBarStyle = .Default
    }
}
