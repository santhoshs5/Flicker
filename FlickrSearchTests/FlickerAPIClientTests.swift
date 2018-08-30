//
//  FlickerAPIClientTests.swift
//  FlickrSearchTests
//
//  Created by Santhosh on 31/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import XCTest

@testable import FlickrSearch


class FlickerAPIClientTests: XCTestCase {
    
    var service: FlickrAPIClient?
    
    override func setUp() {
        super.setUp()
        service = FlickrAPIClient()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func test_fetch_photos() {
        
        let service = self.service!
        
        let expect = XCTestExpectation(description: "callback")
        service.searchPhotos(searchTerm: "Kittens", pageNo: 0, completion:  { result in
            switch result {
            case .failure(let error):
               break
            case .success(let response):
                expect.fulfill()
                XCTAssertEqual (response.photos.photo.count, limit)

            }
        })
        wait(for: [expect], timeout: 3.1)
    }

}


