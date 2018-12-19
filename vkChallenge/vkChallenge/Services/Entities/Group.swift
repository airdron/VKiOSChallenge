//
//  Group.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    let id: Int64
    let name: String
    let screenName: String
    let photo50: URL?
}
