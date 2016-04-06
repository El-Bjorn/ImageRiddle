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

let CROSSHAIRS_CIRCLE_SIZE: CGFloat = 20.0
let CROSSHAIRS_SIZE: CGFloat = 30.0
let CROSSHAIRS_CIRCLE_INSET = (CROSSHAIRS_SIZE - CROSSHAIRS_CIRCLE_SIZE)/2

class TargetView: UIView {
    var crosshairsLayer:CAShapeLayer?
    var crosshairsPos:CGPoint?
    var crosshairsPath:UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set transparent, so we still see the image
        //self.backgroundColor = UIColor.clearColor()
        
        // create CAShapeLayer
        self.crosshairsLayer = CAShapeLayer()
        self.crosshairsLayer?.bounds = CGRectMake(0, 0, CROSSHAIRS_SIZE, CROSSHAIRS_SIZE)
        self.crosshairsLayer?.strokeColor = UIColor.blackColor().CGColor
        self.crosshairsLayer?.fillColor = UIColor.clearColor().CGColor
        self.crosshairsLayer?.lineWidth = 2.0
        self.crosshairsPath = UIBezierPath()
        drawCrossHairs()
        self.crosshairsLayer?.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        self.crosshairsLayer?.path = self.crosshairsPath?.CGPath
        self.layer.addSublayer(self.crosshairsLayer!)

    
    }
    
    func drawCrossHairs() {
        // circle part
        let circlePathBox = CGRectInset((self.crosshairsLayer?.bounds)!, CROSSHAIRS_CIRCLE_INSET, CROSSHAIRS_CIRCLE_INSET);
        let circlePath = UIBezierPath(ovalInRect: circlePathBox)
        circlePath.stroke()
        self.crosshairsPath!.appendPath(circlePath)
        
        // cross part
        let crossVertPath = UIBezierPath()
        var drawPt:CGPoint  // we move this point to draw the line
        drawPt = CGPointMake((self.crosshairsLayer?.bounds.size.width)!/2.0, 0.0)
        crossVertPath.moveToPoint(drawPt)
        drawPt.y = (self.crosshairsLayer?.bounds.height)!
        crossVertPath.addLineToPoint(drawPt)
        
        drawPt = CGPointMake(0.0, (self.crosshairsLayer?.bounds.size.height)!/2.0)
        crossVertPath.moveToPoint(drawPt)
        drawPt.x = (self.crosshairsLayer?.bounds.width)!
        crossVertPath.addLineToPoint(drawPt)
        
        //let crossHorizPath:UIBezierPath = crossVertPath.copy() as! UIBezierPath // copy that vertical path
        crossVertPath.stroke()
        self.crosshairsPath!.appendPath(crossVertPath)
        
        // play with transforms
        /*let currentTrans = self.crosshairsLayer?.transform
        self.crosshairsLayer!.transform = CATransform3DRotate(currentTrans!, CGFloat(M_PI_2), 0.0, 0.0, 1.0)
        crossHorizPath.stroke()
        crosshairsPath!.appendPath(crossHorizPath) */
        
        
        
        
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
        // let CA pick animation speed
        //self.crosshairsLayer?.position = self.crosshairsPos!;
        // our own speed
        let moveAnim = CABasicAnimation(keyPath: "position")
        moveAnim.fromValue = NSValue(CGPoint: (self.crosshairsLayer?.position)!)
        moveAnim.toValue = NSValue(CGPoint: self.crosshairsPos!)
        moveAnim.duration = 2.0
        self.crosshairsLayer?.position = self.crosshairsPos!
        self.crosshairsLayer?.addAnimation(moveAnim, forKey: "position")
        
    }
}
