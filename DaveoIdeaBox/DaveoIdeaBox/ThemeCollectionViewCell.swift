//
//  ThemeCollectionViewCell.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 30/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    // IBOulets
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    
    // Attributes
    var themeDefinition: Idea.themeDefinition? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let loadedThemeDefinition = themeDefinition {
            themeNameLabel?.text = loadedThemeDefinition.printableName
            
            if let imagesNamed = Idea.getThemeImageNamesFor(loadedThemeDefinition.id.hashValue) {
                let randomIndex = Int(arc4random_uniform(UInt32(imagesNamed.count)))
                let image = UIImage(named: imagesNamed[randomIndex])
                
                themeImageView?.image = image
                themeImageView?.contentMode = .ScaleAspectFill
            }
        }
    }
}
