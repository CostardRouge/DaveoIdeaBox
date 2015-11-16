//
//  EntryCollectionViewCell.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class EntryCollectionViewCell: UICollectionViewCell {
    // GUI elements
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ideaThemedImageView: UIImageView!
    @IBOutlet weak var thumbUpCountButton: RoundedButton!
    
    // Attributes
    var entry: Idea? {
        didSet {
            updateUI()
        }
    }
    
    @IBAction func thumbUpButtonTouchUpInside(sender: UIButton) {
        if let loadedEntry = entry {
            loadedEntry.thumbUpCount = loadedEntry.thumbUpCount + 1
            entry = loadedEntry
        }
    }
    
    func updateUI() {
        if let loadedEntry = entry {
            contentLabel?.text = loadedEntry.content
            authorLabel?.text = loadedEntry.authorName.capitalizedString
            thumbUpCountButton.setTitle("\(loadedEntry.thumbUpCount)", forState: .Normal)
            
            
            let imageNamed = Idea().getThemeImageNameFor(loadedEntry.theme) // should be optionnal
            let image = UIImage(named: imageNamed)
       
            ideaThemedImageView?.image = image
            //ideaThemedImageView?.contentMode = .ScaleAspectFill
        }
    }
    
}
