//
//  AppHelper.swift
//  App
//
//  Created by Tommy Yang on 7/31/15.
//  Copyright (c) 2015 Tommy Yang. All rights reserved.
//

import UIKit

class AppHelper: NSObject {
    static func scaleImage(image: UIImage, width: CGFloat) -> UIImage {
        let oldWidth = image.size.width
        let scaleFactor = width/oldWidth
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func runInBackgroundWithBlock(block: noop) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
    
    typealias noop = () -> Void
}
