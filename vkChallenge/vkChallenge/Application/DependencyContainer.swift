//
//  DependencyContainer.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class DependencyContainer {
    
    lazy var urlSession = URLSession.shared

    lazy var credentialStorage = CredentialStorage(key: "AirdronVkChallenge.token")
    
    lazy var networkManager = NetworkManager(urlSession: self.urlSession)
    
    lazy var serviceContainer: ServiceContainer = ServiceContainerImp(networkManager: self.networkManager,
                                                                      credential: self.credentialStorage)
    
    lazy var moduleBuilderFactory: ModuleBuilderFactory = ModuleBuilderFactoryImp(serviceContainer: self.serviceContainer)
    
    lazy var coordinatorFactory: CoordinatorFactory = CoordinatorFactoryImp(moduleBuilderFactory: self.moduleBuilderFactory)
}
