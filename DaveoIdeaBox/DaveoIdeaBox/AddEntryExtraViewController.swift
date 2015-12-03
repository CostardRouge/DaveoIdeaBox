//
//  AddEntryExtraViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 16/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "EntryThemeChoice"

class AddEntryExtraViewController: UIViewController, FaceViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {

    // Outlets
    @IBOutlet weak var entryMoodFaceView: FaceView!
    @IBOutlet weak var faceViewIndicatorLabel: UILabel!
    @IBOutlet weak var themesCollectionView: UICollectionView!
    @IBOutlet weak var allGoodLabel: UILabel!
    
    // Attributes
    var entry: Idea?
    
    var pickerData = Idea.themes
    
    // Faceview happiness value
    var happiness: Int = 80 {
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
        
        // Theme collection view
        themesCollectionView?.dataSource = self
        themesCollectionView?.delegate = self
        themesCollectionView.allowsSelection = true
        themesCollectionView.allowsMultipleSelection = false
        
        // FaceView
        updateFaceViewIndicator()
        entryMoodFaceView?.dataSource = self
        
        // Update all good label
        if let loadedEntry = entry {
            allGoodLabel?.text = String(format: "%@, TOUT EST BON ?", loadedEntry.authorName.uppercaseString)
        }
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
        
        // Filling our entry object
        if let loadedEntry = entry {
            
            // Setting selected theme
            if let indexPaths = themesCollectionView.indexPathsForSelectedItems() {
                if indexPaths.count > 0 {
                    let selectedIndexPath: NSIndexPath = indexPaths[0] as NSIndexPath
                    let selectedThemeDefinition = themeDefinitionForIndexPath(selectedIndexPath)
                    loadedEntry.theme = selectedThemeDefinition.id.hashValue
                }
                else {
                    issue = true
                }
            }
                
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
            
            if issue {
                let alert = UIAlertController(title: "Allô Houston ?!", message: "Il manque quelque chose", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Oops, c'est de ma faute", style: .Default, handler: nil))
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
    
    //MARK: DataSources
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    func collectionView(themesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Idea.themes.count
    }
    
    func numberOfSectionsInCollectionView(themesCollectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(themesCollectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = themesCollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ThemeCollectionViewCell
        
        // Configure the cell
        let themeDefinition = themeDefinitionForIndexPath(indexPath)
        cell.themeDefinition = themeDefinition
        configureThemeCell(cell)
        return cell
    }
    
    func themeDefinitionForIndexPath(indexPath: NSIndexPath) -> Idea.themeDefinition {
        return Idea.themes[indexPath.row]
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = themesCollectionView.cellForItemAtIndexPath(indexPath) as? ThemeCollectionViewCell {
            configureThemeCell(cell)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = themesCollectionView.cellForItemAtIndexPath(indexPath) as? ThemeCollectionViewCell {
           configureThemeCell(cell)
        }
    }
    
    func configureThemeCell(cell: ThemeCollectionViewCell) {
        if cell.selected {
            cell.layer.borderColor = UIColor.blueColor().CGColor
            cell.layer.borderWidth = 4.0
            
            if let oldColor = cell.themeNameLabel.backgroundColor {
                cell.themeNameLabel?.backgroundColor = oldColor.colorWithAlphaComponent(0.9)
            }
        }
        else {
            cell.layer.borderWidth = 0.0
            
            if let oldColor = cell.themeNameLabel.backgroundColor {
                cell.themeNameLabel?.backgroundColor = oldColor.colorWithAlphaComponent(0.3)
            }
        }
    }
}
