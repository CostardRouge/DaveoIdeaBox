//
//  Entry.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

enum EntryType {
    case NoType, Contact, Idea, Suggestion
}

class Entry: NSObject {
    // Properties
    var type: EntryType = .NoType
    var content = String()
    var author =  String()
    var creationDate = NSDate()
    var modificationDate = NSDate()

    // Methods
    func loadFromObject(object: Entry){
        // Copy all object properties in currect object
        self.author = object.author
        self.content = object.content
        self.creationDate = object.creationDate
        self.modificationDate = object.modificationDate
    }
    
    // ...
}