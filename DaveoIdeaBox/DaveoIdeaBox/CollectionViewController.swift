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
private let sectionInsets = UIEdgeInsets(top: -40.0, left: 10.0, bottom: 30.0, right: 10.0)

class EntriesCollectionViewController: UICollectionViewController {
    // GUI elements
    @IBOutlet var entriesCollectionView: UICollectionView!
    
    // Attributes
    private var isViewAppearedOnce = false
    private var entries: [Idea] {
        get {
            return EntryManager.sharedInstance.getEntries(true)
        }
    }
    
    var recentlyCreatedEntry: Idea?
    
    func entryForIndexPath(indexPath: NSIndexPath) -> Idea {
        return entries[indexPath.row]
    }
    
    func reloadCollectionViewData() {
        entriesCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EntryManager.sharedInstance.createRandomEntries()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = true
        
        let center = NSNotificationCenter.defaultCenter()
        
        //center.addObserver(self, selector: "reloadCollectionViewDataAtNewEntry", name: NotificationIdentifiers.newEntry, object: nil)
        center.addObserver(entriesCollectionView, selector: "reloadData", name: NotificationIdentifiers.entriesUpdated, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if self.isViewAppearedOnce {
            //self.entriesCollectionView.reloadData()
        }
        
        // Yes, viewDidLoad was called once
        self.isViewAppearedOnce = true
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showEntryDetail" {
            if let vc = segue.destinationViewController as? EntryViewController {
                let indexPath = entriesCollectionView.indexPathForCell(sender as! UICollectionViewCell)
                let entry = entryForIndexPath(indexPath!)
                vc.entry = entry
            }
        }
    }
    
    @IBAction func submitCompletedViewControllerDismissed(segue:UIStoryboardSegue) {
        
        if let cells = collectionView?.visibleCells() {
            for cell in cells {
                if let entryCell = cell as? EntryCollectionViewCell {
                    print(entryCell.authorLabel)
                }
            }
        }
        
        // Here I gather back the recently created entry
        
        
        //collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: 3, inSection: 1), atScrollPosition: .Top, animated: true)
        print("entry \(recentlyCreatedEntry)")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EntryManager.sharedInstance.getEntries().count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EntryCollectionViewCell
        
        // Configure the cell
        let entry = entryForIndexPath(indexPath)
        cell.entry = entry
        return cell
    }
    
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