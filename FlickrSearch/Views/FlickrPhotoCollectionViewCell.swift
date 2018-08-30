//
//  FlickrPhotoCollectionViewCell.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import UIKit

class FlickrPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView?
    
    func setUp(with photo:FlickrPhoto) -> Void {
        if let url = photo.flickrImageURL {
            photoImageView?.load(url: url, placeholder: nil)
        }
    }
    
}
