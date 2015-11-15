//
//  RoundedButton.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 03/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var borderColor:UIColor = UIColor.redColor()
    @IBInspectable var borderWidth:CGFloat = 5.0
    
    @IBInspectable var drawBorder:Bool = false
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()

        
        if (drawBorder) {
            layer.cornerRadius = frame.size.width/2
            clipsToBounds = true
            
            let borderCGColor = borderColor.CGColor
            layer.borderColor = borderCGColor
            layer.borderWidth = borderWidth
        }
    }
    
}
