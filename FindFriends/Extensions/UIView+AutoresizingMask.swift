//
//  UIView+AutoresizingMask.swift
//  FindFriends
//
//  Created by Вадим Шишков on 14.02.2024.
//

import UIKit

extension UIView {
    func addSubviewWithoutAutoresizingMask(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
