//
//  EntryManager.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 15/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import Foundation

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
        
        for var index = 0; index < 32; ++index {
            let item = Idea()
            item.content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            
            // get ramdom author
            let arrayIndex = arc4random_uniform(UInt32(authors.count))
            let randomAuthorName = authors[Int(arrayIndex)]
            
            item.authorName = randomAuthorName
            item.creationDate = NSDate()
            item.thumbUpCount = Int(0 + arc4random_uniform(UInt32(15)))
            
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
                            entry.authorEmail = item["authorEmail"]! as! String
                            entry.content = item["content"]! as! String
                            entry.thumbUpCount = item["thumbUpCount"]! as! Int
                            entry.mood = item["mood"]! as! Int
                            entry.theme = item["theme"]! as! Int
                            
                            let creationDate = item["creationDate"]! as! Double
                            entry.creationDate = NSDate(timeIntervalSince1970: creationDate)
                            
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