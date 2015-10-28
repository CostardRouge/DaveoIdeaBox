//
//  EntryViewController.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 21/10/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let loadedEntry = entry {
            authorLabel.text = loadedEntry.author
            contentLabel.text = loadedEntry.content  as String
            creationDateLabel.text = loadedEntry.creationDate.description
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
