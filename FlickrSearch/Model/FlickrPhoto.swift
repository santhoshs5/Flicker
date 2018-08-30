//
//  FlickrPhoto.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//
import Foundation

struct FlickrPhoto :Codable {
    
    let id: String
//    let owner: String
    let secret:String
    let server:String
    let farm:Int
//    let title:String
//    let ispublic:Int
//    let isfriend:Int
//    let isfamily:Int
//
    var flickrImageURL:URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg") {
            return url
        }
        return nil
    }
    
}


struct Photos:Codable {
    let page:Int
    let pages:Int
    let perpage:Int
    let total:String
    let photo:[FlickrPhoto]
    
}

struct PhotoSearchResponse:Codable {
    let photos:Photos
    
}

