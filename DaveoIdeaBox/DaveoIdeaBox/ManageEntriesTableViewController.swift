//
//  ManageEntriesTableViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 01/12/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class ManageEntriesTableViewController: UITableViewController {

    private var entries: [Idea] {
        get {
            return EntryManager.sharedInstance.getEntries(true)
        }
    }
    
    func entryForIndexPath(indexPath: NSIndexPath) -> Idea {
        return entries[indexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ideaCell", forIndexPath: indexPath)
        let entry = entryForIndexPath(indexPath)
        
        cell.textLabel?.text = entry.authorName
        cell.detailTextLabel?.text = entry.content
       
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showManageEntryView" {
            if let metvc = segue.destinationViewController as? ManageEntryTableViewController {
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell) {
                        metvc.entry = entryForIndexPath(indexPath)
                    }
                }
            }
        }
    }

}
