//
//  Idea.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class Idea: Serializable {
    // Enums
    typealias themeDefinition = (id: Theme, printableName: String, preferedColor: UIColor)
    typealias moodDefinition = (id: Mood, printableName: String, preferedColor: UIColor)

    enum Theme {
        case Technology, Innovation, HumanRessource, Development, Selfcare, Party, Travel, Responsive, Other
    }
    
    enum Mood: Int {
        case Upset = 20, Sad = 40, Neutral = 55, Happy = 80, Euphoric = 90
    }
    
    static let themes: [themeDefinition] = [
        (id: Theme.Technology, printableName: "Technologie", preferedColor: UIColor.redColor()),
        (id: Theme.Innovation, printableName: "Innovation", preferedColor: UIColor.redColor()),
        (id: Theme.HumanRessource, printableName: "Ressources humaines", preferedColor: UIColor.redColor()),
        (id: Theme.Development, printableName: "Developpement", preferedColor: UIColor.redColor()),
        (id: Theme.Selfcare, printableName: "Bien-être", preferedColor: UIColor.redColor()),
        (id: Theme.Party, printableName: "Festif", preferedColor: UIColor.redColor()),
        (id: Theme.Travel, printableName: "Voyage", preferedColor: UIColor.redColor()),
        (id: Theme.Responsive, printableName: "Buisness responsive", preferedColor: UIColor.redColor()),
        (id: Theme.Other, printableName: "Autre", preferedColor: UIColor.redColor())
    ]
    
    static let moods: [moodDefinition] = [
        (id: Mood.Upset, printableName: "Contrarié", preferedColor: UIColor.redColor()),
        (id: Mood.Neutral, printableName: "Neutre", preferedColor: UIColor.redColor()),
        (id: Mood.Sad, printableName: "Triste", preferedColor: UIColor.redColor()),
        (id: Mood.Happy, printableName: "Joyeux", preferedColor: UIColor.redColor()),
        (id: Mood.Euphoric, printableName: "Euphorique", preferedColor: UIColor.redColor())
    ]

    override init() {
        id = NSUUID().UUIDString
        theme = Theme.Other.hashValue
        mood = Mood.Happy.rawValue
        content = String()
        authorName = String()
        authorEmail = String()
        creationDate = NSDate()
        thumbUpCount = 0
    }
    
    // Attributes
    var id: String
    
    var theme: Int
    var mood: Int
    
    var content: String
    var authorName: String
    var authorEmail: String
    var creationDate: NSDate
    var thumbUpCount: Int
    
    var modificationDate: NSDate?
    var preferedThemedImageName: String?
}