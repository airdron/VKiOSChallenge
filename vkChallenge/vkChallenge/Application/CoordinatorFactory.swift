//
//  CoordinatorFactory.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorPresentable {
    
    var coordinatorFactory: CoordinatorFactory { get set }
}

protocol CoordinatorFactory {
    
    func makeFeedCoordinator(presenter: UIWindow,
                             coordinatorFactory: CoordinatorFactory) -> FeedCoordinator
    
    func makeAuthCoordinator(presenter: UIWindow,
                             coordinatorFactory: CoordinatorFactory) -> AuthCoordinator
}

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    private let moduleBuilderFactory: ModuleBuilderFactory
    
    init(moduleBuilderFactory: ModuleBuilderFactory) {
        self.moduleBuilderFactory = moduleBuilderFactory
    }
    
    func makeFeedCoordinator(presenter: UIWindow,
                             coordinatorFactory: CoordinatorFactory) -> FeedCoordinator {
        return FeedCoordinator(presenter: presenter,
                               moduleBuilder: self.moduleBuilderFactory.makeFeedModuleBuilder(),
                               coordinatorFactory: self)
    }
    
    func makeAuthCoordinator(presenter: UIWindow,
                             coordinatorFactory: CoordinatorFactory) -> AuthCoordinator {
        return AuthCoordinator(presenter: presenter,
                               moduleBuilder: self.moduleBuilderFactory.makeAuthModuleBuilder(),
                               coordinatorFactory: self)
    }
}
