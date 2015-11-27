//
//  AddEntryExtraViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 16/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

let daveoGreenColor = UIColor(red: 0, green: 0.501961, blue: 0, alpha: 1)
let daveoBlueColor = UIColor(red: 0, green: 0.490196, blue: 0.713726, alpha: 1)

class AddEntryExtraViewController: UIViewController, FaceViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {

    // Outlets
    @IBOutlet weak var entryThemePickerView: UIPickerView!
    @IBOutlet weak var entryMoodFaceView: FaceView!
    @IBOutlet weak var faceViewIndicatorLabel: UILabel!
    
    // Attributes
    var entry: Idea?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FaceView
        updateFaceViewIndicator()
        entryMoodFaceView?.dataSource = self
        
        // Add choice to picker view
        entryThemePickerView?.delegate = self
        entryThemePickerView?.dataSource = self
        
        // Select defaut picker view choice
        entryThemePickerView?.selectRow(4, inComponent: 0, animated: false)
    }
    
    func updateFaceViewIndicator() {
        if happiness <= Idea.Mood.Upset.rawValue {
            faceViewIndicatorLabel?.text = "Contrarié"
            faceViewIndicatorLabel?.textColor = UIColor.redColor()
            entryMoodFaceView?.color = UIColor.redColor()
        }
        else if happiness <= Idea.Mood.Sad.rawValue {
            faceViewIndicatorLabel?.text = "Triste"
            faceViewIndicatorLabel?.textColor = UIColor.orangeColor()
            entryMoodFaceView?.color = UIColor.orangeColor()
            
        }
        else if happiness <= Idea.Mood.Neutral.rawValue {
            faceViewIndicatorLabel?.text = "Neutre"
            faceViewIndicatorLabel?.textColor = daveoBlueColor
            entryMoodFaceView?.color = daveoBlueColor
        }
        else if happiness <= Idea.Mood.Happy.rawValue {
            faceViewIndicatorLabel?.text = "Joyeux"
            faceViewIndicatorLabel?.textColor = daveoGreenColor
            entryMoodFaceView?.color = daveoGreenColor
        }
        else {
            faceViewIndicatorLabel?.text = "Euphorique"
            faceViewIndicatorLabel?.textColor = daveoGreenColor
            entryMoodFaceView?.color = daveoGreenColor
        }
    }
    
    func submitEntry() {
        var issue = false // could be a detailled value further
        
        if let loadedEntry = entry {
            // Filling our entry object
            if let selectedRow = entryThemePickerView?.selectedRowInComponent(0) {
                // Setting selected theme
                loadedEntry.theme = pickerData[selectedRow].id.hashValue
                
                // Setting user mood
                if happiness <= Idea.Mood.Upset.rawValue {
                    loadedEntry.mood = Idea.Mood.Upset.rawValue
                }
                else if happiness <= Idea.Mood.Sad.rawValue {
                    loadedEntry.mood = Idea.Mood.Upset.rawValue
                }
                else if happiness <= Idea.Mood.Neutral.rawValue {
                    loadedEntry.mood = Idea.Mood.Upset.rawValue
                }
                else if happiness <= Idea.Mood.Happy.rawValue {
                    loadedEntry.mood = Idea.Mood.Upset.rawValue
                }
                else {
                    loadedEntry.mood = Idea.Mood.Euphoric.rawValue
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
                // Addind the valid entry
                EntryManager.sharedInstance.addEntry(loadedEntry)
                performSegueWithIdentifier("showThankYouForSubmitting", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showThankYouForSubmitting" {
            if let scvc = segue.destinationViewController as? SubmitCompletedViewController {
                scvc.entry = entry
            }
        }
    }
    
    //MARK: IBActions
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
            AppDelegate.postUserActivityNotification()
            let translation = gesture.translationInView(entryMoodFaceView)
            let happinessChange = Int(translation.y / Constants.HappinessGestureScale)
            if (happinessChange != 0) {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: entryMoodFaceView)
            }
        default: break
        }
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].printableName
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selecting")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: DataSources
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}
