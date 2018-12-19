//
//  Endpoints.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

enum Endpoints {
    
    case users
    case feed
    case search
    
    private static let host = "https://api.vk.com/method/"
    
    var url: URL {
        switch self {
        case .users:
            return URL(string: Endpoints.host + "/users.get")!
        case .feed:
            return URL(string: Endpoints.host + "/newsfeed.get")!
        case .search:
            return URL(string: Endpoints.host + "/newsfeed.search")!
        }
    }
}
