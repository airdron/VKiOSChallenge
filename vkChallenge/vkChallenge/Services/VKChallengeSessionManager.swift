//
//  VKChallengeSessionManager.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//
import Foundation

class VKChallengeSessionManager {
    
    private let credential: CredentialStorage
    
    init(credential: CredentialStorage) {
        self.credential = credential
    }
    
    private let userKey = "vkChallenge.user.key"
    
    func save(user: User) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: self.userKey)
        } catch {
            print("Exeption while saving user")
        }
    }
    
    var user: User? {
        guard let userData = UserDefaults.standard.data(forKey: self.userKey),
            let user = try? JSONDecoder().decode(User.self, from: userData) else { return nil }
        return user
    }
    
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: self.userKey)
    }
    
    func save(token: String) {
        self.credential.save(token: token)
    }
    
    func getToken() -> String? {
        return self.credential.getToken()
    }
    
    func deleteToken() {
        self.credential.deleteToken()
    }
    
    var isRegistred: Bool {
        return self.credential.getToken() != nil && self.user != nil
    }
    
    func logout() {
        self.deleteUser()
        self.deleteToken()
    }
}
