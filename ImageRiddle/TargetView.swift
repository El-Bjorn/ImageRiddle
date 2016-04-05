//
//  TargetView.swift
//  ImageRiddle
//
//  Created by BjornC on 4/5/16.
//  Copyright © 2016 Builtlight. All rights reserved.
//

// The job of this uiview instance process touch events
//    and host the cross-hairs layer

import UIKit

class TargetView: UIView {
    var crosshairsLayer:CALayer?
    var crosshairsPos:CGPoint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set transparent, so we still see the image
        self.backgroundColor = UIColor.clearColor()
        //self.alpha = 0.5
    }
    // Needed only to make xcode happy, we're using init(CGRect)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Overriding a UIResponder(UIView parent) method
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        self.crosshairsPos = (touch?.locationInView(self))!
        print("touch position: \(self.crosshairsPos!.x),\(self.crosshairsPos!.y)")
        
    }
}
