//
//  Structures+Globals.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 01/12/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Structures
struct NotificationIdentifiers {
    static let screenSaverTimeUp = "screenSaverTimeUpNotification"
    static let userActivity = "userActivityNotification"
    //static let newEntry = "newEntryNotification"
    static let entriesUpdated = "entriesUpdatedNotification"
}

struct TimeIntervals {
    static let nextAllowedVoteAfter = 60.0
    
    struct ScreenSaver {
        static let timeBeforeActivation = 300.0
    }
}

// MARK: - Globals
let daveoGreenColor = UIColor(red: 0, green: 0.501961, blue: 0, alpha: 1)
let daveoBlueColor = UIColor(red: 0, green: 0.490196, blue: 0.713726, alpha: 1)