//
//  RoundedButton.swift
//  
//
//  Created by Steeve is working on 03/11/15.
//
//

import UIKit

class RoundedButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
    }
    
}
