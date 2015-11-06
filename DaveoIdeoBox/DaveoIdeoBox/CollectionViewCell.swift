//
//  EntryCollectionViewCell.swift
//  DaveoIdeoBox
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
            let newVotesCount = 1
            
            if let entryVotes = loadedEntry.thumbUpCount {
                loadedEntry.thumbUpCount = entryVotes + newVotesCount
            }
            else {
                loadedEntry.thumbUpCount = newVotesCount
            }
            entry = loadedEntry
        }
    }
    
    func updateUI() {
        if let loadedEntry = entry {
            contentLabel?.text = loadedEntry.content
            authorLabel?.text = loadedEntry.author.capitalizedString
            thumbUpCountButton.setTitle("\(loadedEntry.thumbUpCount!)", forState: .Normal)
            
            let imageNamed = "\(Int(1 + arc4random_uniform(UInt32(8))))"
            ideaThemedImageView?.image = UIImage(named: imageNamed)
            //ideaThemedImageView?.contentMode = .ScaleAspectFill
        }
    }
    
    
}
