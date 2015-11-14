//
//  Idea.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class Idea {
    // Enums
    struct Theme {
        static let Undefined = (id: 0, printableName: "N/A", preferedColor: UIColor.redColor())
        static let Technology = (printableName: "Technologie", preferedColor: UIColor.redColor())
        static let Innovation = (printableName: "Innovation", preferedColor: UIColor.redColor())
        static let HumanRessource = (printableName: "Ressources humaines", preferedColor: UIColor.redColor())
        static let Development = (printableName: "Developpement", preferedColor: UIColor.redColor())
        static let Selfcare = (printableName: "Bien-être", preferedColor: UIColor.redColor())
        static let Party = (printableName: "Festif", preferedColor: UIColor.redColor())
        static let Travel = (printableName: "Voyage", preferedColor: UIColor.redColor())
        static let Responsive = (printableName: "Buisness responsive", preferedColor: UIColor.redColor())
    }
    
    enum eTheme {
        case Undefined(Int, String, preferredColor: UIColor)
        case Technology(Int, String, preferredColor: UIColor)
        case Innovation(Int, String, preferredColor: UIColor)
        case HumanRessource(Int, String, preferredColor: UIColor)
        case Development(Int, String, preferredColor: UIColor)
        case Selfcare(Int, String, preferredColor: UIColor)
        case Party(Int, String, preferredColor: UIColor)
        case Travel(Int, String, preferredColor: UIColor)
        case Responsive(Int, String, preferredColor: UIColor)
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