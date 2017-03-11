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

    override func awakeFromNib() {
        super.awakeFromNib()

        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.itemSize = CGSize(width: 140, height: 140)
        self.collectionViewLayout = flowLayout
    }
}
