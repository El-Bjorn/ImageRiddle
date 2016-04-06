//
//  ViewController.swift
//  ImageRiddle

import UIKit

class ViewController: UIViewController {

    @IBOutlet var riddleImageView: UIImageView?
    var targetView:TargetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make sure we have riddleImageView
        if let imageView = self.riddleImageView {
            imageView.image = UIImage(named: "Seasame-St-Characters")
            
            let targetViewFrame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)
            
            self.targetView = TargetView(frame: targetViewFrame)
            if (self.targetView != nil) {
                imageView.addSubview(self.targetView!) // unwrapping ok since we checked it
            }
        }
    }
    
    @IBAction func positionSelectedButton(sender: UIButton) {
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

