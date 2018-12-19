//
//  DebouncedLimiter.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class DebouncedLimiter {
    
    private let limit: TimeInterval
    
    var item: DispatchWorkItem?
    
    init(limit: TimeInterval = 0.5) {
        self.limit = limit
    }
    
    func invalidate() {
        self.item?.cancel()
    }
    
    func execute(action: @escaping Action) {
        self.item?.cancel()
        let item = DispatchWorkItem {
            action()
        }
        self.item = item
        DispatchQueue.main.asyncAfter(deadline: .now() + limit,
                                      execute: item)
    }
    
    
}
