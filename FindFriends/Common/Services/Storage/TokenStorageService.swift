//
//  TokenStorageService.swift
//  FindFriends
//
//  Created by Vitaly on 24.02.2024.
//

import SwiftKeychainWrapper

// MARK: - OAuthTokenStorageProtocol
protocol OAuthTokenStorageProtocol: AnyObject {
    var token: String? { get set }
}

// MARK: - OAuthTokenStorage
final class OAuthTokenStorage: OAuthTokenStorageProtocol {

    // MARK: - Public  properties
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

    // MARK: - Private  properties
    private enum Keys: String {
        case authToken = "Auth token"
    }

    private let keychain = KeychainWrapper.standard

    // MARK: - Initializers
    private init() {}

}
