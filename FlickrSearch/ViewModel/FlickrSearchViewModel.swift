//
//  FlickrSearchViewModel.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import UIKit

protocol FlickrSearchViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToInsert: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class FlickrSearchViewModel {
    
    private weak var delegate: FlickrSearchViewModelDelegate?

    private var photos: [FlickrPhoto] = [FlickrPhoto]()
    
    let apiClient: APIClientProtocol
    
    private var currentPage = 0
    var searchWord:String!
   //var flickrSearchRequest:FlickrSearchRequest!


    init(apiClient: APIClientProtocol = FlickrAPIClient(),delegate:FlickrSearchViewModelDelegate) {
        self.apiClient = apiClient
    ///    self.flickrSearchRequest = request
        self.delegate = delegate
    }
    
    
    var photoCount: Int {
        return photos.count
    }
    
   
    
    func fetchPhotos() {
        guard let searchWord = self.searchWord else {
            return
        }
        
        apiClient.searchPhotos(searchTerm: searchWord, pageNo: self.currentPage, completion:  { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):

                if self.photos.count != 0 {
                    self.currentPage += 1
                }
                
                self.photos.append(contentsOf: response.photos.photo)
                if self.currentPage > 1 {
                    var indexPathsToInsert = [IndexPath]()
                    for i in  limit * self.currentPage..<self.photos.count {
                        let indexPath = IndexPath(item: i, section: 0)
                        indexPathsToInsert.append(indexPath)
                    }
                    self.delegate?.onFetchCompleted(with: indexPathsToInsert)
                } else {
                    self.delegate?.onFetchCompleted(with: .none)
                }
            }
        })
    }
    
    func photo(at index: Int) -> FlickrPhoto? {
        if index >= photos.count {
            return nil
        }
        return photos[index]
    }


}
