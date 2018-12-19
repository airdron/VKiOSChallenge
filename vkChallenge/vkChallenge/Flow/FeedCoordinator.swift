//
//  Coordinator.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCoordinatorFlowPresentable: CoordinatorPresentable {
    
    func startFeedFlow(presenter: UIWindow)
}

extension FeedCoordinatorFlowPresentable where Self: BaseCoordinator {
    
    func startFeedFlow(presenter: UIWindow) {
        let coordinator = self.coordinatorFactory.makeFeedCoordinator(presenter: presenter, coordinatorFactory: self.coordinatorFactory)
        self.addDependency(coordinator)
        coordinator.onFlowFinished = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        coordinator.start()
    }
}

class FeedCoordinator: BaseCoordinator {
    
    var coordinatorFactory: CoordinatorFactory
    private let presenter: UIWindow
    private let moduleBuilder: FeedModuleBuilder
    
    init(presenter: UIWindow,
         moduleBuilder: FeedModuleBuilder,
         coordinatorFactory: CoordinatorFactory) {
        self.presenter = presenter
        self.moduleBuilder = moduleBuilder
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        let module = self.moduleBuilder.makeFeedModule()
        self.presenter.rootViewController = module
    }
}
