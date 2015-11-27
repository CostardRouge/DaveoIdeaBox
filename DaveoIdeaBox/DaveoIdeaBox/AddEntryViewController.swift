//
//  AddEntryViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    // Attributes
    var entry = Idea() {
        didSet {
            // updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        nameTextField?.delegate = self
        emailAdressTextField?.delegate = self
        contentTextView?.delegate = self
    }
    
    func submitEntry() {
        var issue = false // could be a detailled value further
        
        if isViewLoaded() {
            // Checking empty fields
            issue = nameTextField.text?.isEmpty == true || emailAdressTextField.text?.isEmpty == true || contentTextView.text?.isEmpty == true
            
            if (!issue) {
                entry.authorName = nameTextField.text!
                entry.authorEmail = emailAdressTextField.text!
                entry.content = contentTextView.text!
            }

            // Filling our entry object
            if issue {
                let alert = UIAlertController(title: "Allô Houston ?!", message: "Il manque quelque chose", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Oops, c'est de ma faute", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                // Saving the valid entry
                performSegueWithIdentifier("showAddEntryExtraViewController", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddEntryExtraViewController" {
            if let aeevc = segue.destinationViewController as? AddEntryExtraViewController {
                aeevc.entry = entry
            }
        }
    }
    
    //MARK: Actions
    @IBAction func submitEntryButtonTouchUpInside(sender: UIButton) {
        submitEntry()
    }
    
    @IBAction func submitIdeaViewHandleTap(sender: UITapGestureRecognizer) {
        submitEntry()
    }
    
    @IBAction func dissmissAnyKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField == nameTextField) {
            emailAdressTextField.becomeFirstResponder()
            return false
        }
        else if (textField == emailAdressTextField) {
            contentTextView.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // In order to prevent screen saver activation
        AppDelegate.postUserActivityNotification()
        
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // In order to prevent screen saver activation
        AppDelegate.postUserActivityNotification()
        return true
    }
}
