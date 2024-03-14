//
//  UIFont+customFonts.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import UIKit


extension UIFont {

    enum Regular {
        static let small11 = UIFont.systemFont(ofSize: 11, weight: .regular)
        static let small12 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let small13 = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let medium16 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let header24 = UIFont.systemFont(ofSize: 24, weight: .regular)
        static let large = UIFont.systemFont(ofSize: 34, weight: .regular)
    }

    enum Semibold {
        static let small = UIFont.systemFont(ofSize: 12, weight: .semibold)
        static let medium = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }

    enum Bold {
        static let small = UIFont.systemFont(ofSize: 12, weight: .bold)
        static let large = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    enum Medium {
        static let medium = UIFont.systemFont(ofSize: 24, weight: .medium)
    }
}
