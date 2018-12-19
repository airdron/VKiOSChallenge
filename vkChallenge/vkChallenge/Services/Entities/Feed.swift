//
//  Feed.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    
    let response: FeedResponse
}

extension Feed {
    init(data: Data) throws {
        let decoder = JSONDecoder.makeCamelDecoder()
        self = try decoder.decode(Feed.self, from: data)
    }
}

extension Array where Element == Feed {
    
    init(data: Data) throws {
        let decoder = JSONDecoder.makeCamelDecoder()
        self = try decoder.decode([Feed].self, from: data)
    }
}
