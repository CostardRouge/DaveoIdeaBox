//
//  NSDate+Comparison.swift
//  DaveoIdeaBox
//
//  Created by Steeve is working on 30/11/15.
//  Copyright © 2015 Daveo. All rights reserved.
//

import Foundation

//extension NSDate: Equatable {}
extension NSDate: Comparable {}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}