//
//  SearchFriendsViewController.swift
//  FindFriends
//
//  Created by Вадим Шишков on 29.02.2024.
//

import UIKit

final class SearchFriendsViewController: UIViewController {
    private let searchFriendsView = SearchFriendsView()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск"
        textField.backgroundColor = .searchTextFieldBackground
        textField.layer.cornerRadius = 10
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        let leftImageView = UIImageView(image: UIImage(resource: .loupe))
        leftView.addSubview(leftImageView)
        leftImageView.center = leftView.center
        leftView.tintColor = .searchTextFieldTint
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        let rightImageView = UIImageView(image: UIImage(resource: .filter))
        rightView.addSubview(rightImageView)
        rightImageView.center = rightView.center
        rightView.tintColor = .searchTextFieldTint
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        let placeholder = NSAttributedString(
            string: "Поиск",
            attributes: [
                .foregroundColor: UIColor.searchTextFieldTint
            ]
        )
        textField.attributedPlaceholder = placeholder
        return textField
    }()
    
    override func loadView() {
        self.view = searchFriendsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        title = "Рекомендации"
        navigationItem.titleView = searchTextField
   
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchTextField.frame = CGRect(x: 0, y: 0, width: searchFriendsView.bounds.width - 32, height: 36)
    }
}
