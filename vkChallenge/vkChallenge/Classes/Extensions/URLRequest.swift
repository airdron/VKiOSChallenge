//
//  URLRequest.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

extension URLRequest {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case head = "HEAD"
        case delete = "DELETE"
        case put = "PUT"
        case patch = "PATCH"
    }
    
    init(url: URL, method: HTTPMethod) {
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
}
