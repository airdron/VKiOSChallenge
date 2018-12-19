//
//  User.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: Int64
    let firstName: String
    let lastName: String
    let photo50: URL?
}

extension User {
    init(data: Data) throws {
        let decoder = JSONDecoder.makeCamelDecoder()
        self = try decoder.decode(User.self, from: data)
    }
}

extension Array where Element == User {
    
    init(data: Data) throws {
        let decoder = JSONDecoder.makeCamelDecoder()
        self = try decoder.decode([User].self, from: data)
    }
}
