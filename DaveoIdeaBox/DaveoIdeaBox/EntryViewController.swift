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
    @IBOutlet weak var ideaThemedImageView: UIImageView!

    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var themeButton: UIButton!
    
    @IBOutlet weak var deleteEntryButton: RoundedButton!
    
    // Attributes
    var entry: Idea?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGUI()
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
            
            let imagesNamed = Idea().getThemeImageNamesFor(loadedEntry.theme) // should be optionnal
            let randomIndex = Int(arc4random_uniform(UInt32(imagesNamed.count)))
            let image = UIImage(named: imagesNamed[randomIndex])
            
            ideaThemedImageView?.image = image
            ideaThemedImageView?.contentMode = .ScaleAspectFill
        }
    }
    

    
    @IBAction func thumbUpTouchUpInside(sender: UIButton) {
        // Model mechanism
        entry?.thumbUpCount = (entry?.thumbUpCount)! + 1
        
        // GUI mechanism
        setupGUI()
    }
    
    @IBAction func deleteEntryButtonTouchUpInside(sender: AnyObject) {
        print("deleteEntryButtonTouchUpInside")
        
        let alertController = UIAlertController(title: "Supprimer ?!", message: "C'est definitif...", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .Cancel) { (action) in
            print("Deletion cancelled")
        }
        
        let destructiveAction = UIAlertAction(title: "Supprimer", style: .Destructive) { (action) in
            print("Deletion cancelled")
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
       print("secretTapGesture")
        deleteEntryButton.hidden = !deleteEntryButton.hidden
    }
    
    @IBAction func addIdeaViewHandleTap(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("entryViewControllerDismissed", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("entryViewControllerDismissed")
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
