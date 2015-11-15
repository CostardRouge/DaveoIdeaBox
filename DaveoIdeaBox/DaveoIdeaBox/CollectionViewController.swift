//
//  EntriesCollectionViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 20/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "EntryCell"
private let sectionInsets = UIEdgeInsets(top: -40.0, left: 10.0, bottom: 10.0, right: 10.0)

class EntriesCollectionViewController: UICollectionViewController {
    // GUI elements
    @IBOutlet var entriesCollectionView: UICollectionView!
    
    // Attributes
    private var isViewAppearedOnce = false
    private var entries = [Idea]()
    
    func entryForIndexPath(indexPath: NSIndexPath) -> Idea {
        // var section = indexPath.section;
        // var row = indexPath.row;
        return entries[indexPath.row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = true

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Fill test entries
        let authors = ["cyril", "steeve", "malicia", "mathieu", "lucile", "antoine", "christophe", "mustapha", "riad", "elias", "guillaume", "alice", "helene", "arnaud", "sinthuyan", "gilles", "charly", "saadna"]
        
        for var index = 0; index < 32; ++index {
            let item = Idea()
            item.content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
            
            // get ramdom author
            let arrayIndex = arc4random_uniform(UInt32(authors.count))
            let randomAuthor = authors[Int(arrayIndex)]
            
            item.author = randomAuthor
            item.creationDate = NSDate()
            item.thumbUpCount = Int(0 + arc4random_uniform(UInt32(15)))
            
            //.insert(item, atIndex: 0)
            entries.append(item)
        }
        
        // Let's sort all entries by thumb up count
        entries = entries.sort { $0.thumbUpCount > $1.thumbUpCount }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.isViewAppearedOnce {
            self.entriesCollectionView.reloadData()
            print("reloadData")
        }
        
        // Yes, viewDidLoad was called once
        self.isViewAppearedOnce = true
    }

    /*
    // MARK: - Navigation
    
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showEntryDetail" {
            let indexPath = entriesCollectionView.indexPathForCell(sender as! UICollectionViewCell)
            let vc = segue.destinationViewController as! EntryViewController
            let entry = entryForIndexPath(indexPath!)
            
            //let cell = sender as! EntryCollectionViewCell
            vc.entry = entry
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return entries.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EntryCollectionViewCell
    
        // Configure the cell
        let entry = entryForIndexPath(indexPath)
        
        // cell.backgroundColor = UIColor.redColor()
        cell.entry = entry
//        cell.authorLabel?.text = entry.author.capitalizedString
//        cell.contentLabel?.text = entry.content
//        cell.thumbUpCountButton.setTitle("\(entry.thumbUpCount!)", forState: .Normal)
        
        
        //cell.ideaThemedImageView?.contentMode = .ScaleAspectFill
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let defaultSize: CGSize = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        
        //let screenWidth = view.frame.width
        //let itemsOnRows:Int = (screenWidth / defaultSize.width)
        
        switch indexPath.item {
        case 0:
            return CGSize(width: (defaultSize.width * 3) + 20.0, height: defaultSize.height)
        case 1:
            return CGSize(width: (defaultSize.width * 2) + 10.0, height: defaultSize.height)
        default:
            break
        }
        return defaultSize
    }
    
    //3
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

}