//
//  EntryViewController.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 21/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    // GUI elements
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var thumbUpCount: UILabel!
    @IBOutlet weak var ideaThemedImageView: UIImageView!
    
    // Attributes
    var entry: Idea?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGUI()
    }
    
    func setupGUI() {
        if let loadedEntry = entry {
            contentLabel?.text = loadedEntry.content
            authorLabel?.text = makeAuthorLabelText(loadedEntry.author)
            creationDateLabel.text = makeCreationDateLabelText(loadedEntry.creationDate)
            thumbUpCount.text = makeThumbUpCountLabelText(loadedEntry.thumbUpCount)
            
            let imageNamed = "\(Int(1 + arc4random_uniform(UInt32(8))))"
            ideaThemedImageView?.image = UIImage(named: imageNamed)
        }
    }
    
    @IBAction func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        let tapAlert = UIAlertController(title: "Swiped", message: "SwipeLeft", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    @IBAction func seeOtherIdeasTouchUpInside(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func thumbUpTouchUpInside(sender: UIButton) {
        // Model mechanism
        entry?.thumbUpCount = (entry?.thumbUpCount)! + 1
        
        // GUI mechanism
        setupGUI()
    }
    
    // GUI helper methods
    func makeAuthorLabelText(authorName:String) -> String {
        return String(format: "%@", authorName.uppercaseString)
    }
    
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
