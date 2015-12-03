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
    }
}
