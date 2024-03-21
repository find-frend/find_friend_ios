//
//  TokenStorageService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import SwiftKeychainWrapper

protocol OAuthTokenStorageProtocol: AnyObject {
    var token: String? { get set }
}

final class OAuthTokenStorage: OAuthTokenStorageProtocol {
    static let shared = OAuthTokenStorage()

    var token: String? {
        get {
            keychain.string(forKey: Keys.authToken.rawValue)
        }
        set {
            guard let newValue else {
                keychain.removeObject(forKey: Keys.authToken.rawValue)
                return
            }
            keychain.set(newValue, forKey: Keys.authToken.rawValue)
        }
    }

    private enum Keys: String {
        case authToken = "Token"
    }

    private let keychain = KeychainWrapper.standard
    private init() {}
}
