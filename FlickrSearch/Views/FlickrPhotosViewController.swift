//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import UIKit

let numberOfRows = 3

class FlickrPhotosViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView?
    
    fileprivate let reuseIdentifier = "FlickrCell"
    var flickrSearchViewModel:FlickrSearchViewModel?


    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 


}


extension FlickrPhotosViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.photosCollectionView?.isHidden = true
        prepareViewForSearch(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



extension FlickrPhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrSearchViewModel?.photoCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FlickrPhotoCollectionViewCell
            else { return UICollectionViewCell() }
        
        if let photo = flickrSearchViewModel?.photo(at: indexPath.row) {
            cell.setUp(with: photo)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchReusableView", for: indexPath)
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if flickrSearchViewModel != nil && indexPath.row == (flickrSearchViewModel!.photoCount - 4) {
            flickrSearchViewModel?.fetchPhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfRows - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfRows))
            return CGSize(width: size, height: size)
        } else {
            // default size.
            return CGSize(width: 90, height: 90)
        }
    }
}

extension FlickrPhotosViewController {
    
    func prepareViewForSearch(with text: String?) -> Void {
//        let FlickrSearchRequest = FlickrSearchRequest.search(forQuery: text!, page: 0)
        flickrSearchViewModel = FlickrSearchViewModel(delegate: self)
        flickrSearchViewModel?.searchWord = text!
        flickrSearchViewModel?.fetchPhotos()
        activityIndicator.startAnimating()
    }
}


extension FlickrPhotosViewController : FlickrSearchViewModelDelegate {
    
    func onFetchCompleted(with newIndexPathsToInsert: [IndexPath]?) {
        if newIndexPathsToInsert == nil {
            DispatchQueue.main.async { [weak self] in
                self?.photosCollectionView?.isHidden = false
                self?.activityIndicator.stopAnimating()
                self?.photosCollectionView?.reloadData()
            }
        }else{
            if newIndexPathsToInsert != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.photosCollectionView?.insertItems(at: newIndexPathsToInsert!)
                }
            }
        }
    }
    
    func onFetchFailed(with reason: String){
        
    }
}
