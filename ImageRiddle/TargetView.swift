//
//  TargetView.swift
//  ImageRiddle
//

// The jobs of this uiview class are to process touch events
//    and host the cross-hairs layer

import UIKit

let CROSSHAIRS_CIRCLE_SIZE: CGFloat = 20.0
let CROSSHAIRS_SIZE: CGFloat = 30.0
let CROSSHAIRS_CIRCLE_INSET = (CROSSHAIRS_SIZE - CROSSHAIRS_CIRCLE_SIZE)/2

class TargetView: UIView {
    private var crosshairsLayer:CAShapeLayer
    //private var crosshairsPath:UIBezierPath? // it's property so we can access it from drawrect
   
    
    // Needed only to make xcode happy, we're using init(CGRect)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect) {
        self.crosshairsLayer = CAShapeLayer() // create shape layer
        super.init(frame: frame)
        
        // set transparent, so we still see the image
        self.backgroundColor = UIColor.clearColor()
        
        // CAShapeLayer properties are set here, drawing must be done in drawrect
        self.crosshairsLayer.bounds = CGRectMake(0, 0, CROSSHAIRS_SIZE, CROSSHAIRS_SIZE)
        self.crosshairsLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)
        
        self.crosshairsLayer.backgroundColor = UIColor.redColor().CGColor   // testing / show drawing on layer
        
        self.crosshairsLayer.strokeColor = UIColor.blackColor().CGColor // crosshairs drawing color
        self.crosshairsLayer.fillColor = UIColor.clearColor().CGColor   // we only want an outline

        self.layer.addSublayer(self.crosshairsLayer)

    
    }
    
    
    override func drawRect(rect: CGRect) {
        // circle part of crosshairs
        let circlePathBox = CGRectInset((self.crosshairsLayer.bounds), CROSSHAIRS_CIRCLE_INSET,
                                                                        CROSSHAIRS_CIRCLE_INSET);
        let crossHairsBezPath = UIBezierPath(ovalInRect: circlePathBox)
        
        // cross part of crosshairs
        var drawPt:CGPoint // our drawing point (pen tip)
        
        // draw vertical first
        drawPt = CGPointMake((self.crosshairsLayer.bounds.size.width)/2.0, 0.0)
        crossHairsBezPath.moveToPoint(drawPt) // move point without drawing
        drawPt.y = self.crosshairsLayer.bounds.height // move down
        crossHairsBezPath.addLineToPoint(drawPt)
        
        // draw horizontal
        drawPt = CGPointMake(0, self.crosshairsLayer.bounds.size.height/2.0)
        crossHairsBezPath.moveToPoint(drawPt)
        drawPt.x = self.crosshairsLayer.bounds.width // move to right
        crossHairsBezPath.addLineToPoint(drawPt)
        
        self.crosshairsLayer.path = crossHairsBezPath.CGPath
        
        print("called drawRect")
    }
    
    
    // Overriding a UIResponder(UIView parent) method
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let crosshairsPos = touch.locationInView(self)
            print("touch position: \(crosshairsPos.x),\(crosshairsPos.y)")
            
            self.crosshairsLayer.position = crosshairsPos
            self.setNeedsDisplay()
        }
    }
}
