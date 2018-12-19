//
//  FeedResponse.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct FeedResponse: Decodable {
    
    let items: [Post]
    let profiles: [User]
    let groups: [Group]
    let nextFrom: String?
}
