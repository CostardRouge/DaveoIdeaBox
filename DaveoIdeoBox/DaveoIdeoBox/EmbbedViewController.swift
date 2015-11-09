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
    
    var trueContributeViewCenter: CGPoint {
        get {
            let addIdeaViewCenter = addIdeaView.center
            let contributeViewCenter = contributeView.center
            let x = contributeViewCenter.x
            let y = contributeViewCenter.y + addIdeaViewCenter.y
            return CGPoint(x: x, y: y)
        }
    }

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
        transition.startingPoint = trueContributeViewCenter
        transition.bubbleColor = addIdeaView.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = trueContributeViewCenter
        transition.bubbleColor = addIdeaView.backgroundColor!
        return transition
    }

}
