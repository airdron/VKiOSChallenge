//
//  Coordinator.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

public protocol Coordinator: class {
    
    func start()
}

open class BaseCoordinator: Coordinator {
    
    public init() {}
    
    public var onFlowFinished: Action?
    
    public var childCoordinators: [BaseCoordinator] = [BaseCoordinator]()
    
    open func start() {
        assertionFailure("must be overridden")
    }
    
    public func addDependency(_ coordinator: BaseCoordinator) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else { return }
        self.childCoordinators.append(coordinator)
    }
    
    public func removeDependency(_ coordinator: BaseCoordinator?) {
        guard !self.childCoordinators.isEmpty, let coordinator = coordinator else { return }
        
        for (index, element) in self.childCoordinators.enumerated() {
            if ObjectIdentifier(element) == ObjectIdentifier(coordinator) {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
}
