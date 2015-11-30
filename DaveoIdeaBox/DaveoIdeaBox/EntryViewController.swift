//
//  EntryViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 21/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    // GUI elements
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var thumbUpCount: UILabel!
    @IBOutlet weak var thumbUpCountButton: RoundedButton!
    
    @IBOutlet weak var ideaThemedImageView: UIImageView!

    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var themeButton: UIButton!
    
    @IBOutlet weak var deleteEntryButton: RoundedButton!
    
    // Attributes
    var entry: Idea? {
        didSet {
            setupGUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGUI()
        
        // Handle swipe gestures
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let loadedEntry = entry {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right:
                    entry = EntryManager.sharedInstance.getEntryAt(Direction.Right, of: loadedEntry)
                case UISwipeGestureRecognizerDirection.Left:
                    entry = EntryManager.sharedInstance.getEntryAt(Direction.Left, of: loadedEntry)
                default:
                    break
                }
            }
        }
    }
    
    func setupGUI() {
        if let loadedEntry = entry {
            contentTextView?.text = loadedEntry.content
            authorButton?.setTitle(loadedEntry.authorName.uppercaseString, forState: .Normal)
            
            if let themeName = Idea().getThemePrintableNameFor(loadedEntry.theme) {
                themeButton?.setTitle(themeName.uppercaseString, forState: .Normal)
            }
            
            creationDateLabel?.text = makeCreationDateLabelText(loadedEntry.creationDate)
            thumbUpCount?.text = makeThumbUpCountLabelText(loadedEntry.thumbUpCount)
            
            var image: UIImage?
            if let imageNamed = loadedEntry.preferedImageTheme {
                image = UIImage(named: imageNamed)
            }
            else {
                let imagesNamed = Idea().getThemeImageNamesFor(loadedEntry.theme) // should be optionnal
                let randomIndex = Int(arc4random_uniform(UInt32(imagesNamed.count)))
                image = UIImage(named: imagesNamed[randomIndex])
            }
            
            ideaThemedImageView?.image = image
            ideaThemedImageView?.contentMode = .ScaleAspectFill
        }
    }
    
    @IBAction func thumbUpTouchUpInside(sender: UIButton) {
        // Model mechanism
        entry?.thumbUpCount = (entry?.thumbUpCount)! + 1
        
        // Locking the vote button for 1 min
        thumbUpCountButton.enabled = false
        let oldColor = thumbUpCountButton.fillColor
        thumbUpCountButton.fillColor = UIColor.grayColor()
        performSelector("unlockThumbUpCountButton:", withObject: oldColor, afterDelay: 60.0)
        
        // GUI mechanism
        setupGUI()
    }
    
    func unlockThumbUpCountButton(oldColor: AnyObject) {
        thumbUpCountButton.enabled = true
        if let color = oldColor as? UIColor {
            thumbUpCountButton.fillColor = color
        }
    }
    
    @IBAction func deleteEntryButtonTouchUpInside(sender: AnyObject) {
        print("deleteEntryButtonTouchUpInside")
        
        let alertController = UIAlertController(title: "Supprimer ?!", message: "C'est definitif...", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .Cancel) { (action) in
            // No action for deletion cancelling
        }
        
        let destructiveAction = UIAlertAction(title: "Supprimer", style: .Destructive) { (action) in
            if let loadedEntry = self.entry {
                EntryManager.sharedInstance.deleteEntry(loadedEntry, needToBeSorted: true)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func secretTapGesture(sender: AnyObject) {
        deleteEntryButton.hidden = !deleteEntryButton.hidden
    }
    
    @IBAction func addIdeaViewHandleTap(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("entryViewControllerDismissed", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "entryViewControllerDismissed" {
            if let aevc = segue.destinationViewController as? AddEntryViewController {
                aevc.entry = entry!
            }
        }
    }
    
    // GUI helper methods
    func makeCreationDateLabelText(creationDate:NSDate) -> String {
        return String(format: "PUBLIÉ LE: %@", creationDate.description)
    }
    
    func makeThumbUpCountLabelText(possibleThumbUpCount:Int?) -> String {
        if let thumbUpCount = possibleThumbUpCount {
            return String(format: "%dx vote%@", thumbUpCount, (thumbUpCount > 1 ? "s" : ""))
        }
        return String(format: "Pas de votes")
    }
}
