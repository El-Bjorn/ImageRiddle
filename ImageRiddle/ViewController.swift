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
            
            let targetViewFrame = CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height)
            
            self.targetView = TargetView(frame: targetViewFrame)
            if (self.targetView != nil) {
                imageView.addSubview(self.targetView!) // unwrapping ok since we checked it
            }
        }
    }
    
    @IBAction func positionSelectedButton(_ sender: UIButton) {
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

