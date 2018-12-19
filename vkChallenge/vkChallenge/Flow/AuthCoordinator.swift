//
//  AuthCoordinator.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

protocol AuthCoordinatorFlowPresentable: CoordinatorPresentable {
    
    func startAuthFlow(presenter: UIWindow, completion: Action?)
}

extension AuthCoordinatorFlowPresentable where Self: BaseCoordinator {
    
    func startAuthFlow(presenter: UIWindow, completion: Action?) {
        let coordinator = self.coordinatorFactory.makeAuthCoordinator(presenter: presenter, coordinatorFactory: self.coordinatorFactory)
        self.addDependency(coordinator)
        coordinator.onFlowFinished = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        coordinator.onCompletion = {
            completion?()
        }
        coordinator.start()
    }
}

class AuthCoordinator: BaseCoordinator {
    
    var coordinatorFactory: CoordinatorFactory
    private let presenter: UIWindow
    private let moduleBuilder: AuthModuleBuilder
    var onCompletion: Action?
    
    init(presenter: UIWindow,
         moduleBuilder: AuthModuleBuilder,
         coordinatorFactory: CoordinatorFactory) {
        self.presenter = presenter
        self.moduleBuilder = moduleBuilder
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        let module = self.moduleBuilder.makeAuthModule()
        module.onCompletion = { [weak self] in
            print(VKSdk.accessToken()?.accessToken)
            self?.onCompletion?()
        }
        self.presenter.rootViewController = module
    }
}
