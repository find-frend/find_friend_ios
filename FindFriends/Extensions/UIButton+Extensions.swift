//
//  UIButton_Extensions.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit

fileprivate let minimumHitArea = CGSize(width: 44, height: 44)
private var xoAssociationKey: UInt8 = 0

extension UIButton {
    
    var isIncreasedHitAreaEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &xoAssociationKey) != nil)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        if isIncreasedHitAreaEnabled {
            let buttonSize = self.bounds.size
            let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
            let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
            let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
            return (largerFrame.contains(point)) ? self : nil
        }
        return self
    }
}

