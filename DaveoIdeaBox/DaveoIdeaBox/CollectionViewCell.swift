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
            
            
            let imagesNamed = Idea().getThemeImageNamesFor(loadedEntry.theme) // should be optionnal
            let randomIndex = Int(arc4random_uniform(UInt32(imagesNamed.count)))
            
            let image = UIImage(named: imagesNamed[randomIndex])
            //image = image?.applyBlurWithRadius(CGFloat(1), tintColor: nil, saturationDeltaFactor: 1.0)
       
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
