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

    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }

}
