//
//  LoginService.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol LoginService: class {
    
    func setup()
    func login(completion: @escaping (Result<Void>) -> Void)
}

class LoginServiceImp: NSObject, LoginService {
    
    private let appId = "6746063"
    private let networkManager: NetworkManager
    private var loginCompletion: ((Result<Void>) -> Void)?
    private let sessionManager: VKChallengeSessionManager
    
    private var defaultQueryItems: [URLQueryItem] {
        let version = URLQueryItem(name: "v", value: "5.87")
        var items = [version]
        if let token = self.sessionManager.getToken() {
            items.append(URLQueryItem(name: "access_token", value: token))
        }
        return items
    }
    
    init(networkManager: NetworkManager,
         sessionManager: VKChallengeSessionManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
    }
    
    func setup() {
        
        if let instance = VKSdk.initialize(withAppId: self.appId) {
            instance.register(self)
        }
    }
    
    func login(completion: @escaping (Result<Void>) -> Void) {
        
        loginCompletion = completion
        
        let scope = [VK_PER_WALL, VK_PER_FRIENDS]
        
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                self.fetchUser()
            } else if let error = error {
                completion(.failure(error))
            } else {
                VKSdk.authorize(scope)
            }
        }
    }
    
    private func fetchUser() {
        guard var urlComponents = URLComponents(url: Endpoints.users.url, resolvingAgainstBaseURL: true) else { return }
        let queryItem = URLQueryItem(name: "fields", value: "photo_50")
        urlComponents.queryItems = self.defaultQueryItems + [queryItem]
        guard let url = urlComponents.url else { return }
        let request = URLRequest.init(url: url, method: .get)
        self.networkManager.performRequest(request: request, processData: { return try UserResponse(data: $0) }) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let selfUser = response.response.first {
                        print(selfUser)
                        self?.sessionManager.save(user: selfUser)
                        self?.loginCompletion?(.success(()))
                    } else {
                        self?.loginCompletion?(.failure(ApiError.unknownError))
                    }
                case .failure(let error):
                    self?.loginCompletion?(.failure(error))
                }
            }
        }
    }
}

extension LoginServiceImp: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            self.fetchUser()
        } else if let error = result.error {
            loginCompletion?(.failure(error))
        }
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            self.fetchUser()
        } else if let error = result.error {
            loginCompletion?(.failure(error))
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        loginCompletion?(.failure(ApiError.unknownError))
    }
    
    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        if let token = newToken {
            self.sessionManager.save(token: token.accessToken)
        }
    }
}
