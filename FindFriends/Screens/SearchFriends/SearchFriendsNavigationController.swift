//
//  SearchFriendsNavigationController.swift
//  FindFriends
//
//  Created by Вадим Шишков on 29.02.2024.
//

import UIKit

final class SearchFriendsNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.primeDark,
            .font: UIFont.Medium.medium
        ]
    }
}
