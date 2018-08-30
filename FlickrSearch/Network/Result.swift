//
//  Result.swift
//  FlickrSearch
//
//  Created by Santhosh on 30/08/18.
//  Copyright © 2018 Santhosh. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
