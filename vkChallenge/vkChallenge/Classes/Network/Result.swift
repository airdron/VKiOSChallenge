//
//  Result.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
}
