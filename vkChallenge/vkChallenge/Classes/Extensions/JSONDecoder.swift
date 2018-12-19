//
//  JSONDecoder.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    
    static func makeCamelDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
