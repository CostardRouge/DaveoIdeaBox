//
//  AddEntryViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate, FaceViewDataSource {
    // GUI elements
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var entryThemePickerView: UIPickerView!
    @IBOutlet weak var entryMoodFaceView: FaceView!
    @IBOutlet weak var faceViewIndicatorLabel: UILabel!
    
    // Attributes
    var entry = Idea() {
        didSet {
            // updateUI()
        }
    }
    var pickerData = Idea.themes
    
    // Faceview happiness value
    var happiness: Int = 100 {
        didSet {
            happiness = min(max(happiness, 0), 100)
            entryMoodFaceView?.setNeedsDisplay()
            
           updateFaceViewIndicator()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 1
    }
    
    func updateFaceViewIndicator() {
        
        if happiness <= Idea.Mood.Upset.rawValue {
            faceViewIndicatorLabel?.text = "Contrarié"
        }
        else if happiness <= Idea.Mood.Sad.rawValue {
            faceViewIndicatorLabel?.text = "Triste"
        }
        else if happiness <= Idea.Mood.Neutral.rawValue {
            faceViewIndicatorLabel?.text = "Neutre"
        }
        else if happiness <= Idea.Mood.Happy.rawValue {
            faceViewIndicatorLabel?.text = "Joyeux"
        }
        else {
            faceViewIndicatorLabel?.text = "Euphorique"
        }
    }
    
    override func viewDidLoad() {
        updateFaceViewIndicator()
        
        // So many delegates
        nameTextField?.delegate = self
        emailAdressTextField?.delegate = self
        contentTextView?.delegate = self
        entryMoodFaceView?.dataSource = self
        
        // Add choice to picker view
        entryThemePickerView?.delegate = self
        entryThemePickerView?.dataSource = self
        
        // Select defaut picker view choice
        entryThemePickerView?.selectRow(4, inComponent: 0, animated: true)
    }
    
    func submitEntry() {
        var issue = false // could be a detailled value further
        
        if isViewLoaded() {
            // Checking empty fields
            issue = nameTextField.text?.isEmpty == true || emailAdressTextField.text?.isEmpty == true || contentTextView.text?.isEmpty == true
            
            // Filling our entry object
            if let selectedRow = entryThemePickerView?.selectedRowInComponent(0) {
                entry.theme = pickerData[selectedRow].id.hashValue
                if (!issue) {
                    entry.authorName = nameTextField.text!
                    entry.authorEmail = emailAdressTextField.text!
                    entry.content = contentTextView.text!
                    
                    if happiness <= Idea.Mood.Upset.rawValue {
                        entry.mood = Idea.Mood.Upset.rawValue
                    }
                    else if happiness <= Idea.Mood.Sad.rawValue {
                        entry.mood = Idea.Mood.Upset.rawValue
                    }
                    else if happiness <= Idea.Mood.Neutral.rawValue {
                        entry.mood = Idea.Mood.Upset.rawValue
                    }
                    else if happiness <= Idea.Mood.Happy.rawValue {
                        entry.mood = Idea.Mood.Upset.rawValue
                    }
                    else {
                        entry.mood = Idea.Mood.Euphoric.rawValue
                    }
                }
            }
            else {
                issue = true
            }
            
            if issue {
                let alert = UIAlertController(title: "Allô Houston ?!", message: "Il manque quelque chose", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Oops, c'est de ma faute", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                // Saving the valid entry
                EntryManager.sharedInstance.addEntry(entry)
                print(entry.creationDate)
                
                
//                print(entry.toJson() as? String)
                //print(entry.toJsonString(true))
                
//                print(entry.id)
//                print(entry.authorEmail)
//                print(entry.authorName)
//                print(entry.content)
//                print(entry.mood)
                
//                print(entry.modificationDate)
//                print(entry.thumbUpCount)
                
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
    
    @IBAction func faceViewHandlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state
        {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(entryMoodFaceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if (happinessChange != 0) {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: entryMoodFaceView)
            }
        default: break
        }
    }
    
    @IBAction func dissmissAnyKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: Delegates
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
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
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].printableName
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
