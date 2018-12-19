//
//  Observer.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class Observer<T> {
    
    typealias ObserveAction = (_ oldValue: T, _ newValue: T) -> Void
    
    private var observers = [ObjectIdentifier: ObserveAction]()
    
    public var value: T {
        didSet {
            observers.values.forEach { (action) in
                action(oldValue, value)
            }
        }
    }
    
    func add(observer: AnyObject,
                    observeAction: @escaping ObserveAction) {
        observers[ObjectIdentifier(observer)] = observeAction
    }
    
    func remove(observer: AnyObject) {
        observers.removeValue(forKey: ObjectIdentifier(observer))
    }
    
    init(value: T) {
        self.value = value
    }
}
