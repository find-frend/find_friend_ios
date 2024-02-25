//
//  TokenStorageService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import SwiftKeychainWrapper

import Foundation

final class OAuthTokenStorage {
    
    var token: String? {
        
        get {
            let token: String? = KeychainWrapper.standard.string(forKey: "Auth token")
            return token
        }
        
        set(newValue) {
            if newValue == nil {
                KeychainWrapper.standard.removeObject(forKey: "Auth token")
                return
            }
            KeychainWrapper.standard.set(newValue!, forKey: "Auth token")
        }
    }
    
}
