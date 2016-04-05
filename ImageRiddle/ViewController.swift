//
//  ViewController.swift
//  ImageRiddle
//
//  Created by BjornC on 4/5/16.
//  Copyright © 2016 Builtlight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var riddleImageView: UIImageView!
    var targetView:TargetView? = nil
    
    @IBAction func positionSelectedButton(sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // add the image to our UIImageView
        //self.riddleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        //self.riddleImageView.backgroundColor = UIColor.blueColor()
        self.riddleImageView.image = UIImage(named: "Seasame-St-Characters")
        //
        // create the TargetView and add it as a subview of riddleImageView
        // TargetView's frame is the bounds of riddleImageView
        let targetViewFrame = CGRectMake(0,0,self.riddleImageView.frame.size.width,self.riddleImageView.frame.size.height)
        self.targetView = TargetView(frame: targetViewFrame)
        
        //riddleImageView.backgroundColor = UIColor.redColor()
        riddleImageView.addSubview(self.targetView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

