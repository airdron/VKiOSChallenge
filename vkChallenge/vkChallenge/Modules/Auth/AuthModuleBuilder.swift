//
//  AuthModuleBuilder.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class AuthModuleBuilder {
    
    private let loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func makeAuthModule() -> AuthViewController {
        return AuthViewController(loginService: self.loginService)
    }
}
