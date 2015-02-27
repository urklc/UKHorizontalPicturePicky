//
//  UKHorizontalPicturePicky.swift
//  MedicalBrochure
//
//  Created by ugur on 27/02/15.
//  Copyright (c) 2015 urklc. All rights reserved.
//

import UIKit

let hppImageViewTag = 1

class UKHorizontalPicturePicky: UICollectionView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.itemSize = CGSizeMake(140, 140)
        self.collectionViewLayout = flowLayout
    }
}
