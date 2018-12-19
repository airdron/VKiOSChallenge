//
//  ServiceContainer.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

protocol ServiceContainer {
    
    var apiService: ApiService { get }
    var loginService: LoginService { get }
    var vkChallengeSessionManager: VKChallengeSessionManager { get }
}

class ServiceContainerImp: ServiceContainer {
    
    private let networkManager: NetworkManager
    private let credential: CredentialStorage
    
    init(networkManager: NetworkManager, credential: CredentialStorage) {
        self.networkManager = networkManager
        self.credential = credential
    }
    
    lazy var apiService: ApiService = ApiServiceImp(networkManager: self.networkManager,
                                                    sessionManager: self.vkChallengeSessionManager)
    
    lazy var loginService: LoginService = LoginServiceImp(networkManager: self.networkManager,
                                                          sessionManager: self.vkChallengeSessionManager)
    
    lazy var vkChallengeSessionManager = VKChallengeSessionManager(credential: self.credential)
}
