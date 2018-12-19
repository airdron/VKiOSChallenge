//
//  ModuleBuilderFactory.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

protocol ModuleBuilderFactory {
    
    func makeAuthModuleBuilder() -> AuthModuleBuilder
    
    func makeFeedModuleBuilder() -> FeedModuleBuilder
}

final class ModuleBuilderFactoryImp: ModuleBuilderFactory {
    
    private let serviceContainer: ServiceContainer
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func makeAuthModuleBuilder() -> AuthModuleBuilder {
        return AuthModuleBuilder(loginService: self.serviceContainer.loginService)
    }
    
    func makeFeedModuleBuilder() -> FeedModuleBuilder {
        return FeedModuleBuilder(apiService: self.serviceContainer.apiService)
    }
}
