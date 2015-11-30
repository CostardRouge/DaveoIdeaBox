//
//  EntryManager.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 15/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import Foundation

enum Direction {
    case Left, Right
}

class EntryManager {
    // MARK: - Attributes
    private var entries = [Idea]()
    
    static let sharedInstance = EntryManager()
    
    private struct Constants {
        static let entryCollectionSerilazedFileName: String = "entries.json"
    }
    
    init() {
        loadEntries()
    }
    
    // MARK: - Methods
    func createRandomEntries(needToBeSorted: Bool? = false) {
        // Fill test entries
        let authors = ["cyril", "steeve", "malicia", "mathieu", "lucile", "antoine", "christophe", "mustapha", "riad", "elias", "guillaume", "alice", "helene", "arnaud", "sinthuyan", "gilles", "charly", "saadna"]
        
        let contents = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
            "Lancez une foire aux idées et des séances de créativité",
            "Une boîte à idées est un système organisé par lequel un salarié d'une entreprise peut, etc",
            "Découvrez une application web propre à l'innovation participative et au travail collaboratif.",
            "Voila une excellente façon d'impliquer les salariés à l'activité de l'entreprise !",
            "Le principe des boîtes à idées en entreprise ne date pas d'aujourd'hui !",
            "In an ideal world this website wouldn’t exist"
        ]
        
        for var index = 0; index < 32; ++index {
            let item = Idea()
            
            var arrayIndex = arc4random_uniform(UInt32(authors.count))
            let randomAuthorName = authors[Int(arrayIndex)]
            item.authorName = randomAuthorName
            
            arrayIndex = arc4random_uniform(UInt32(contents.count))
            let randomContent = contents[Int(arrayIndex)]
            item.content = randomContent
            
            item.creationDate = NSDate()
            item.thumbUpCount = Int(0 + arc4random_uniform(UInt32(15)))
            
            
            item.mood = Int(arc4random_uniform(UInt32(100)))
            item.theme = Int(arc4random_uniform(UInt32(Idea.themes.count)))
            
            entries.append(item)
        }
        
        
        
        if let sortDemand = needToBeSorted {
            if sortDemand {
                sortEntries()
            }
        }
    }
    
    func addEntry(entry: Idea, needToBeSorted: Bool? = false) -> Bool {
        // Adding the new entry
        entries.append(entry)
        
        if let sortDemand = needToBeSorted {
            if sortDemand {
                sortEntries()
            }
        }
        
        // We could persist the date at the application terminating
        return persistEntries()
    }
    
    func getEntryAt(direction: Direction, of: Idea) -> Idea? {

        
        if (entries.count > 1) {
            if let found = entries.indexOf(of) {
                let maxIndex = (entries.count - 1)
                
                let newIndex = found + (direction == .Left ? 1 : -1)
                
                if newIndex > maxIndex {
                    return entries.first
                }
                else if newIndex < 0 {
                    return entries.last
                } else {
                    return entries[newIndex]
                }
            }
        }
        return nil
    }
    
    func deleteEntry(entry: Idea, needToBeSorted: Bool? = false) -> Bool {
        // Deleting the entry
        if let found = entries.indexOf(entry) {
            entries.removeAtIndex(found)
        }
        
        if let sortDemand = needToBeSorted {
            if sortDemand {
                sortEntries()
            }
        }
        
        // We could persist the date at the application terminating
        return persistEntries()
    }
    
    func sortEntries() {
        // Let's sort all entries by thumb up count
        entries = entries.sort { $0.thumbUpCount > $1.thumbUpCount }
    }
    
    func persistEntries() -> Bool {
        if let data = entries.toJson(true) {
            if let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String? {
                let documentsURL = NSURL(fileURLWithPath: documentsPath)
                let fileURL = documentsURL.URLByAppendingPathComponent(Constants.entryCollectionSerilazedFileName)
                data.writeToURL(fileURL, atomically: true)
            }
        }
        return false
    }
    
    func loadEntries() -> Bool {
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String? {
            let documentsURL = NSURL(fileURLWithPath: documentsPath)
            let fileURL = documentsURL.URLByAppendingPathComponent(Constants.entryCollectionSerilazedFileName)
            
            if let jsonData = NSData(contentsOfURL: fileURL) {
                //print(jsonData)
                do {
                    if let JSONObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [[String: AnyObject]] {
                        
                        // array of serialized Idea classes
                        //print(JSONObject[0])
                        
                        for item in JSONObject {
                            let entry = Idea()
                            
                            entry.id = item["id"]! as! String
                            entry.authorName = item["authorName"]! as! String
                            entry.preferedImageTheme = item["preferedImageTheme"]! as? String
                            
                            entry.authorEmail = item["authorEmail"]! as! String
                            entry.content = item["content"]! as! String
                            entry.thumbUpCount = item["thumbUpCount"]! as! Int
                            entry.mood = item["mood"]! as! Int
                            entry.theme = item["theme"]! as! Int
                            
                            let creationDateInDouble = item["creationDate"]! as! Double
                            entry.creationDate = NSDate(timeIntervalSince1970: creationDateInDouble)                            
                
                            let lastVoteDateInDouble = item["lastVoteDate"]! as! Double
                            entry.lastVoteDate = NSDate(timeIntervalSince1970: lastVoteDateInDouble)
                            
                            //let entry.modificationDate = item["entry.modificationDate"]! as! Double
                            //entry.modificationDate = NSDate(timeIntervalSince1970: entry.modificationDate)
                            
                            entries.append(entry)
                        }
                    }
                } catch _ {
                    print("str.writeToURL failed")
                }
                return true
            }
        }
        return false
    }
    
    func getEntries(needToBeSorted: Bool? = false) -> [Idea] {
        
        if let sortDemand = needToBeSorted {
            if sortDemand {
                sortEntries()
            }
        }
        return entries
    }

}