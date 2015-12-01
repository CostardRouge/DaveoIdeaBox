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
    @IBOutlet weak var thumbUpCountUpButton: RoundedButton!
    
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
            
            // Locking the cell vote button for 1 min
            lockThumbUpCountButton()
            performSelector("unlockThumbUpCountButton", withObject: nil, afterDelay: TimeIntervals.nextAllowedVoteAfter)
        }
    }
    
    func unlockThumbUpCountButton() {
        thumbUpCountUpButton.enabled = true
    }
    
    func lockThumbUpCountButton() {
        thumbUpCountUpButton.enabled = false
    }
    
    func updateUI() {
        
        if let loadedEntry = entry {
            
            // Check if last vote date in on 1 min interval
            let nextAllowedVoteDate = loadedEntry.lastVoteDate.dateByAddingTimeInterval(TimeIntervals.nextAllowedVoteAfter)
            let nowDateTimeIntervalSince1970 = NSDate().timeIntervalSince1970
            if nextAllowedVoteDate.timeIntervalSince1970 < nowDateTimeIntervalSince1970 {
                unlockThumbUpCountButton()            }
            else {
                lockThumbUpCountButton()
                let timeForNextAllowedVote = nextAllowedVoteDate.timeIntervalSince1970 - nowDateTimeIntervalSince1970 as Double
                performSelector("unlockThumbUpCountButton", withObject: nil, afterDelay: timeForNextAllowedVote)
            }
            
            contentLabel?.text = loadedEntry.content
            authorLabel?.text = loadedEntry.authorName.capitalizedString
            thumbUpCountButton.setTitle("\(loadedEntry.thumbUpCount)", forState: .Normal)
            
            // IMAGE
            var image: UIImage?
            if let imageNamed = loadedEntry.preferedImageTheme {
                image = UIImage(named: imageNamed)
            }
            else {
                let imagesNamed = Idea.getThemeImageNamesFor(loadedEntry.theme) // should be optionnal
                let randomIndex = Int(arc4random_uniform(UInt32(imagesNamed.count)))
                image = UIImage(named: imagesNamed[randomIndex])
            }
            
            image = image?.applyBlurWithRadius(CGFloat(1), tintColor: nil, saturationDeltaFactor: 1.0)
       
            ideaThemedImageView?.image = image
            ideaThemedImageView?.contentMode = .ScaleAspectFill
        }
    }
    
    func applyBlurEffect(image: UIImage) -> UIImage{
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        let  blurredImage = UIImage(CIImage: resultImage)
        return blurredImage
    }
    
}
