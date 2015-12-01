//
//  ManageEntryTableViewController.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 01/12/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class ManageEntryTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var authorCell: UITableViewCell!
    @IBOutlet weak var emailCell: UITableViewCell!
    @IBOutlet weak var creationDateCell: UITableViewCell!
    @IBOutlet weak var thumbUpCountCell: UITableViewCell!
    @IBOutlet weak var themeCell: UITableViewCell!
    @IBOutlet weak var contentCell: UITableViewCell!
    
    //MARK: - Members
    var entry: Idea? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if isViewLoaded() {
            if let loadedEntry = entry {
                authorCell?.detailTextLabel?.text = loadedEntry.authorName
                emailCell?.detailTextLabel?.text = loadedEntry.authorEmail
                creationDateCell?.detailTextLabel?.text = loadedEntry.creationDate.description
                thumbUpCountCell?.detailTextLabel?.text = loadedEntry.thumbUpCount.description
                themeCell?.detailTextLabel?.text = Idea.getThemePrintableNameFor(loadedEntry.theme)
                contentCell?.detailTextLabel?.text = loadedEntry.content
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        return nil
//    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
