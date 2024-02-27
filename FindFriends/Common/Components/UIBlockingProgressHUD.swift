//
//  UIBlockingProgressHUD.swift
//  FindFriends
//
//  Created by Artem Novikov on 26.02.2024.
//

import UIKit
import ProgressHUD

// MARK: - UIBlockingProgressHUD
struct UIBlockingProgressHUD {

    private static var window: UIWindow? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }

    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }

    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }

}

