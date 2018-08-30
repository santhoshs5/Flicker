//
//  FlickrAPIClient.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import UIKit

protocol APIClientProtocol {
    func searchPhotos(searchTerm:String,pageNo:Int, completion: @escaping (Result<PhotoSearchResponse, DataResponseError>) -> Void)
}


class FlickrAPIClient: APIClientProtocol {
    

    func searchPhotos(searchTerm:String,pageNo:Int, completion: @escaping (Result<PhotoSearchResponse, DataResponseError>) -> Void) {
        let url = self.flickrSearchURLForSearchTerm(searchTerm, pageNo)
//        let searchAPIRequest = FlickrSearchRequest.search(forQuery: searchTerm, page: pageNo)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlRequest = URLRequest(url: url!)
        
//        let encodedURLRequest = urlRequest.encode(with: searchAPIRequest?.parameters)
        
        let task = session.dataTask(with: urlRequest ) {
            (data, response, error) in
            // check for any errors
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            // safety check for data
            guard let decodedResponse = try? JSONDecoder().decode(PhotoSearchResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
            
        }
        task.resume()

        
    }
    
    fileprivate func flickrSearchURLForSearchTerm(_ searchTerm:String,_ pageNo:Int) -> URL? {
        
        guard let escapedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        
        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKeyValue)&text=\(escapedTerm)&per_page=\(limit)&page=\(pageNo)&format=json&nojsoncallback=1"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }


}
