//
//  CredentialStorage.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

// TODO: NEED TO SAVE TO KEYCHAIN
class CredentialStorage {
    
    private var token: String?
    private let key: String
    
    init(key: String) {
        self.key = key
        self.token = self.loadToken()
    }
    
    func save(token: String) {
        self.token = token
        UserDefaults.standard.set(token, forKey: self.key)
    }
    
    func deleteToken() {
        self.token = nil
        UserDefaults.standard.removeObject(forKey: self.key)
    }
    
    func loadToken() -> String? {
        return UserDefaults.standard.string(forKey: self.key)
    }
    
    public var unsafeToken: String {
        guard let token = self.token, !token.isEmpty else {
            fatalError("Token error")
        }
        return token
    }
    
    func getToken() -> String? {
        guard let token = self.token, !token.isEmpty else {
            return nil
        }
        return token
    }
}
