//
//  RoundedButton.swift
//  
//
//  Created by Steeve is working on 03/11/15.
//
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
    }
    
}
