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
    fileprivate var crosshairsLayer:CAShapeLayer
    
    // Needed only to make xcode happy, we're using init(CGRect)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect) {
        self.crosshairsLayer = CAShapeLayer() // create shape layer
        super.init(frame: frame)
        
        // set transparent, so we still see the image
        self.backgroundColor = UIColor.clear
        
        // CAShapeLayer properties are set here, drawing must be done in drawrect
        self.crosshairsLayer.bounds = CGRect(x: 0, y: 0, width: CROSSHAIRS_SIZE, height: CROSSHAIRS_SIZE)
        self.crosshairsLayer.position = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        
        //self.crosshairsLayer.backgroundColor = UIColor.redColor().CGColor   // testing / show drawing on layer
        
        self.crosshairsLayer.strokeColor = UIColor.black.cgColor // crosshairs drawing color
        self.crosshairsLayer.fillColor = UIColor.clear.cgColor   // we only want an outline

        self.layer.addSublayer(self.crosshairsLayer)

    
    }
    
    
    override func draw(_ rect: CGRect) {
        // circle part of crosshairs
        let circlePathBox = (self.crosshairsLayer.bounds).insetBy(dx: CROSSHAIRS_CIRCLE_INSET,
                                                                        dy: CROSSHAIRS_CIRCLE_INSET);
        let crossHairsBezPath = UIBezierPath(ovalIn: circlePathBox)
        
        // cross part of crosshairs
        var drawPt:CGPoint // our drawing point (pen tip)
        
        // draw vertical first
        drawPt = CGPoint(x: (self.crosshairsLayer.bounds.size.width)/2.0, y: 0.0)
        crossHairsBezPath.move(to: drawPt) // move point without drawing
        drawPt.y = self.crosshairsLayer.bounds.height // move down
        crossHairsBezPath.addLine(to: drawPt)
        
        // draw horizontal
        drawPt = CGPoint(x: 0, y: self.crosshairsLayer.bounds.size.height/2.0)
        crossHairsBezPath.move(to: drawPt)
        drawPt.x = self.crosshairsLayer.bounds.width // move to right
        crossHairsBezPath.addLine(to: drawPt)
        
        self.crosshairsLayer.path = crossHairsBezPath.cgPath
        
        print("called drawRect")
    }
    
    
    // Overriding a UIResponder(UIView parent) method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let crosshairsPos = touch.location(in: self)
            print("touch position: \(crosshairsPos.x),\(crosshairsPos.y)")
            
            self.crosshairsLayer.position = crosshairsPos
            self.setNeedsDisplay()
        }
    }
}
