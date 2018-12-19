//
//  UserResponse.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    
    let response: [User]
}

extension UserResponse {
    init(data: Data) throws {
        let decoder = JSONDecoder.makeCamelDecoder()
        self = try decoder.decode(UserResponse.self, from: data)
    }
}
