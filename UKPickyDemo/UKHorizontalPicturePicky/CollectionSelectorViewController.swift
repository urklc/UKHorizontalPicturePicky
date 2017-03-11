//
//  CollectionSelectorViewController.swift
//  MedicalBrochure
//
//  Created by ugur on 22/02/15.
//  Copyright (c) 2015 urklc. All rights reserved.
//

import UIKit

let kFakeCopyImageViewTag = 1986

@objc
protocol ImagePanGestureHandler: class {
    func handlePan(_ recognizer: UIPanGestureRecognizer)
}

class CollectionSelectorViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagename:String = ""
    var delegate:ImagePanGestureHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: imagename)
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true

        let panGesture = UIPanGestureRecognizer(target: delegate, action: #selector(ImagePanGestureHandler.handlePan(_:)))
        imageView!.addGestureRecognizer(panGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
