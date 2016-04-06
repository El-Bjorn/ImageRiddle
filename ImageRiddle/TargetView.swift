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

let CROSSHAIRS_CIRCLE_SIZE: CGFloat = 10.0
let CROSSHAIRS_SIZE: CGFloat = 20.0

class TargetView: UIView {
    var crosshairsLayer:CAShapeLayer?
    var crosshairsPos:CGPoint?
    var crosshairsPath:UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set transparent, so we still see the image
        self.backgroundColor = UIColor.clearColor()
        //self.alpha = 0.5
        
        // create CAShapeLayer
        self.crosshairsLayer = CAShapeLayer()
        self.crosshairsLayer?.bounds = CGRectMake(0, 0, CROSSHAIRS_SIZE, CROSSHAIRS_SIZE)
        self.crosshairsLayer?.strokeColor = UIColor.blackColor().CGColor
        self.crosshairsLayer?.fillColor = UIColor.clearColor().CGColor
        self.crosshairsLayer?.lineWidth = 3.0
        self.crosshairsPath = UIBezierPath()
        drawCrossHairs()
        self.crosshairsLayer?.position = CGPointMake(50, 50)
        //self.crosshairsPath?.lineWidth = 1.0
        self.crosshairsLayer?.path = self.crosshairsPath?.CGPath
        self.layer.addSublayer(self.crosshairsLayer!)

    
    }
    
    func drawCrossHairs() {
        //let crossHairsColor = UIColor.whiteColor().CGColor
        //let crossHairsPath = UIBezierPath()
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(0, 0, CROSSHAIRS_SIZE, CROSSHAIRS_SIZE))
        
        //circlePath.lineWidth = 5.0
        
        circlePath.stroke()
        self.crosshairsPath!.appendPath(circlePath)
        
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
