//
//  ViewController.swift
//  UKPickyDemo
//
//  Created by ugur on 27/02/15.
//  Copyright (c) 2015 urklc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UKHorizontalPicturePicky!
    
    let imagesData = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as UICollectionViewCell
        
        if let imgView = cell.contentView.viewWithTag(hppImageViewTag) as? UIImageView {
            imgView.image = UIImage(named: imagesData[indexPath.row])
        } else {
            var img = UIImageView(frame: CGRectMake(6, 6, 128, 128))
            img.tag = hppImageViewTag
            img.image = UIImage(named: imagesData[indexPath.row])
            cell.contentView.addSubview(img)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let imgView = cell.contentView.viewWithTag(hppImageViewTag) {
            if let imgView = imgView as? UIImageView {
                imgView.image = nil
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var collectionSelectorViewController = CollectionSelectorViewController(imageName: imagesData[indexPath.row])
        collectionSelectorViewController.modalPresentationStyle = .Popover
        collectionSelectorViewController.preferredContentSize = CGSizeMake(400, 400)
        collectionSelectorViewController.delegate = self
        
        let popoverViewController = collectionSelectorViewController.popoverPresentationController
        popoverViewController?.permittedArrowDirections = UIPopoverArrowDirection.Down
        popoverViewController?.passthroughViews = [collectionView]
        popoverViewController?.sourceView = collectionView.cellForItemAtIndexPath(indexPath)?.contentView.viewWithTag(hppImageViewTag)
        popoverViewController?.sourceRect = CGRect(x: 50, y: 0, width: 1, height: 1)
        
        presentViewController(collectionSelectorViewController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        var translatedPoint = recognizer.translationInView(self.view)
        let imageView = recognizer.view as? UIImageView
        
        switch (recognizer.state) {
        case UIGestureRecognizerState.Began:
            dismissViewControllerAnimated(false, completion: nil);
            
            var rect = imageView?.frame
            var frame = imageView?.convertRect(rect!, toView: self.view)
            imageView?.frame = frame!
            
            // To prevent flashing when started mobving the UIImageView object
            let fakeCopy = UIImageView(frame: rect!)
            fakeCopy.image = imageView?.image
            imageView?.superview?.addSubview(fakeCopy)
            
            // Move the actual UIImageView to self
            imageView?.tag = kFakeCopyImageViewTag
            self.view.addSubview(imageView!)
            
            UIView.animateWithDuration(0.3,
                delay: 0.0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: {
                    self.view.viewWithTag(kFakeCopyImageViewTag)?.transform = CGAffineTransformMakeScale(0.4, 0.4)
                    
                    return
                },
                completion: { finished in })
            
            break;
        case UIGestureRecognizerState.Cancelled, UIGestureRecognizerState.Failed, UIGestureRecognizerState.Ended:
            self.view.viewWithTag(kFakeCopyImageViewTag)?.tag = 0
            break;
        default:
            break;
        }
        
        imageView?.center = recognizer.locationInView(imageView?.superview);
    }
}