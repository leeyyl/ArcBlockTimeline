//
//  StringExtension.swift
//  ArcBlockTimeline
//
//  Created by lee on 2021/7/5.
//  Copyright © 2021 com.arc.block. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // set line minimum height
    var attributed: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 24
        return NSAttributedString(string: self, attributes: [.paragraphStyle: style])
    }
    
    // judge string whether or not url
    var isUrl: Bool {
        let pattern = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regextestmobile.evaluate(with: self)
    }
    
}
