//
//  SubmitCompletedViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 15/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class SubmitCompletedViewController: UIViewController {
    
    // GUI elements
    @IBOutlet weak var thankYouLabel: UILabel!
    
    // Attributes
    var entry: Idea? {
        didSet {
            updateUI()
        }
    }
    
    // GUI : Label handlers
    func getThankYouLabelText(authorName: String) -> String {
        return String(format: "Merci %@,\nc'est sympa d'avoir participé !", authorName.capitalizedString)
    }
    
    func updateUI() {
        if let loadedEntry = entry {
            thankYouLabel?.text = getThankYouLabelText(loadedEntry.authorName)
        }
    }
    
     // Methods
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        updateUI()
    }
}
