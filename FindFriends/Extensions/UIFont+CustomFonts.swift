//
//  UIFont+customFonts.swift
//  FindFriends
//
//  Created by Вадим Шишков on 20.02.2024.
//

import UIKit

extension UIFont {
    enum Regular {
        static var small11: UIFont { UIFont.systemFont(ofSize: 11, weight: .regular) }
        static var small12: UIFont { UIFont.systemFont(ofSize: 12, weight: .regular) }
        static var small13: UIFont { UIFont.systemFont(ofSize: 13, weight: .regular) }
        static var medium: UIFont { UIFont.systemFont(ofSize: 17, weight: .regular) }
        static var large: UIFont { UIFont.systemFont(ofSize: 34, weight: .regular) }
    }
    
    enum Semibold {
        static var medium: UIFont { UIFont.systemFont(ofSize: 17, weight: .semibold) }
    }
}
