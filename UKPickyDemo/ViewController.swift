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
        
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as UICollectionViewCell
        
        if let imgView = cell.contentView.viewWithTag(hppImageViewTag) as? UIImageView {
            imgView.image = UIImage(named: imagesData[indexPath.row])
        } else {
            let img = UIImageView(frame: CGRect(x: 6, y: 6, width: 128, height: 128))
            img.tag = hppImageViewTag
            img.image = UIImage(named: imagesData[indexPath.row])
            cell.contentView.addSubview(img)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let imgView = cell.contentView.viewWithTag(hppImageViewTag) {
            if let imgView = imgView as? UIImageView {
                imgView.image = nil
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionSelectorViewController = CollectionSelectorViewController()
        collectionSelectorViewController.imagename = imagesData[indexPath.row]
        collectionSelectorViewController.modalPresentationStyle = .popover
        collectionSelectorViewController.preferredContentSize = CGSize(width: 400, height: 400)
        collectionSelectorViewController.delegate = self
        
        let popoverViewController = collectionSelectorViewController.popoverPresentationController
        popoverViewController?.permittedArrowDirections = UIPopoverArrowDirection.down
        popoverViewController?.passthroughViews = [collectionView]
        popoverViewController?.sourceView = collectionView.cellForItem(at: indexPath)?.contentView.viewWithTag(hppImageViewTag)
        popoverViewController?.sourceRect = CGRect(x: 50, y: 0, width: 1, height: 1)
        
        present(collectionSelectorViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
    }

}
extension ViewController: ImagePanGestureHandler {
    
    func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let imageView = recognizer.view as? UIImageView
        
        switch (recognizer.state) {
        case UIGestureRecognizerState.began:
            dismiss(animated: false, completion: nil);
            
            let rect = imageView?.frame
            let frame = imageView?.convert(rect!, to: self.view)
            imageView?.frame = frame!
            
            // To prevent flashing when started mobving the UIImageView object
            let fakeCopy = UIImageView(frame: rect!)
            fakeCopy.image = imageView?.image
            imageView?.superview?.addSubview(fakeCopy)
            
            // Move the actual UIImageView to self
            imageView?.tag = kFakeCopyImageViewTag
            self.view.addSubview(imageView!)
            
            UIView.animate(withDuration: 0.3,
                delay: 0.0,
                options: UIViewAnimationOptions(),
                animations: {
                    self.view.viewWithTag(kFakeCopyImageViewTag)?.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                    
                    return
                },
                completion: { finished in })
            
            break;
        case UIGestureRecognizerState.cancelled, UIGestureRecognizerState.failed, UIGestureRecognizerState.ended:
            self.view.viewWithTag(kFakeCopyImageViewTag)?.tag = 0
            break;
        default:
            break;
        }
        
        imageView?.center = recognizer.location(in: imageView?.superview);
    }
}
