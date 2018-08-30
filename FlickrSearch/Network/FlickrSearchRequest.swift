//
//  FlickrSearchRequest.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//


import Foundation



let flickrApi    =  "https://api.flickr.com/services/rest"
let flickrMethod =  "flickr.photos.search"
let apiKeyValue  =  "739b660ea3629666d04b83ad0a19a381"
let limit        =  20


let methodKey =         "method"
let apiKey    =         "api_key"
let nojsoncallbackKey = "nojsoncallback"
let formatKey =         "format"
let safeSearchKey =     "safe_search"
let textKey =           "text"
let perPageKey =        "per_page"
let pageKey =           "page"




struct FlickrSearchRequest {
    
    let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension FlickrSearchRequest {
    static func search(forQuery searchText: String, page: Int) -> FlickrSearchRequest? {

    guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil}
    
    let parameters : [String: String] = [
        methodKey:          flickrMethod,
        apiKey:             apiKeyValue,
        nojsoncallbackKey:  "1",
        formatKey:          "json",
        safeSearchKey:      "1",
        textKey:            encodedText,
        perPageKey:         "\(limit)",
        pageKey:            "\(page)"
    ]
        return FlickrSearchRequest(parameters: parameters)

    }
    
}
