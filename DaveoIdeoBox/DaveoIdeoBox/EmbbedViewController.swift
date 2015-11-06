//
//  EmbbedViewController.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 06/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit
import BubbleTransition

class EmbbedViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var addIdeaView: UIView!
    @IBOutlet weak var contributeView: UIView!
    
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addIdeaButtonTouchUpInside(sender: UIButton) {
        performSegueWithIdentifier("addIdeaModal", sender: nil)
    }
    
    @IBAction func handleSingleTap(recognizer: UITapGestureRecognizer) {
        performSegueWithIdentifier("addIdeaModal", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addIdeaModal" {
            let controller = segue.destinationViewController
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .Custom
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = contributeView.center
        transition.bubbleColor = contributeView.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = contributeView.center
        transition.bubbleColor = contributeView.backgroundColor!
        return transition
    }

}
