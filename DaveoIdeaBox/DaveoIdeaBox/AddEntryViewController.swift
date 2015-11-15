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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var entryThemePickerView: UIPickerView!
    @IBOutlet weak var entryMoodFaceView: FaceView!
    @IBOutlet weak var faceViewIndicatorLabel: UILabel!
    
    // Attributes
    var entry = Idea()
    var pickerData = [String]()
    
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
        if happiness >= 60 {
            faceViewIndicatorLabel?.text = "Joyeux"
        }
        else if happiness <= 60 && happiness > 45 {
            faceViewIndicatorLabel?.text = "Neutre"
        }
        else if happiness <= 45 && happiness > 15  {
            faceViewIndicatorLabel?.text = "Triste"
        }
        else {
            faceViewIndicatorLabel?.text = "Contrarié"
        }
    }
    
    override func viewDidLoad() {
        updateFaceViewIndicator()
        
        // So many delegates
        nameTextField.delegate = self
        emailAdressTextField.delegate = self
        contentTextView.delegate = self
        entryMoodFaceView.dataSource = self
        
        // Add entry theme
        pickerData.append(Idea.Theme.Technology.printableName)
        pickerData.append(Idea.Theme.Innovation.printableName)
        pickerData.append(Idea.Theme.HumanRessource.printableName)
        pickerData.append(Idea.Theme.Development.printableName)
        pickerData.append(Idea.Theme.Selfcare.printableName)
        pickerData.append(Idea.Theme.Party.printableName)
        pickerData.append(Idea.Theme.Travel.printableName)
        pickerData.append(Idea.Theme.Responsive.printableName)
        
        // Add choice to picker view
        entryThemePickerView.delegate = self
        entryThemePickerView.dataSource = self
        
        // Select defaut picker view choice
        entryThemePickerView.selectRow(4, inComponent: 0, animated: true)
    }
    
    func submitEntry() {
        if isViewLoaded() {
            let emptyFields = nameTextField.text?.isEmpty == true || emailAdressTextField.text?.isEmpty == true || contentTextView.text?.isEmpty == true
            
            if emptyFields {
                let alert = UIAlertController(title: "Allô Houston ?!", message: "Il manque quelque chose", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Oops, c'est de ma faute", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
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
        return pickerData[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
