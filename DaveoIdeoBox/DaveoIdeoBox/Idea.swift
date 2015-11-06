//
//  Idea.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class Idea {
    // Enums
    enum Theme {
        case Undefined, Technology, Innovation, HumanRessource, Developpement, Selfcare, Party, Travel, Responsive
    }
    
    enum Mood {
        case Undefined, Upset, Neutral, Sad, Happy
    }
    
    // Attributes
    var id = NSUUID().UUIDString
    
    var theme = Theme.Undefined
    var mood = Mood.Undefined
    var preferedThemedImageName: String?
    
    var content = String()
    var author = String()
    var creationDate = NSDate()
    var modificationDate: NSDate?
    var thumbUpCount: Int?
}