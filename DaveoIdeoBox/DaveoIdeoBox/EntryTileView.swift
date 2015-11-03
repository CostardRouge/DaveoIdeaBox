//
//  EntryTileView.swift
//  DaveoIdeoBox
//
//  Created by Steeve is working on 03/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import UIKit

@IBDesignable
class EntryTileView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = CGFloat(7)

    override func drawRect(rect: CGRect) {
        layer.cornerRadius = cornerRadius
    }

}
