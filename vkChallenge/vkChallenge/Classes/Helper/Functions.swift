//
//  Functions.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

public func printAndFail<T>(_ message: String, file: String = #file, line: Int = #line) -> T? {
    print(message + " file: \(file) line: \(line)")
    return nil
}
