//
//  TmpScreenViewController.swift
//  FindFriends
//
//  Created by Vitaly on 08.02.2024.
//

import UIKit

class TmpScreenViewController: UIViewController {
    
    let firstName =  "User1"
    let lastName = "1User"
    let email = "ert3@gmail.com"
    let password =  "4379dfdfd44"
    
    var getFriendsNetworkService = FriendsServiceProvider()
    var usersServiceProvider = UsersServiceProvider()
    
    var oAuthTokenStorage = OAuthTokenStorage()
    
    let tmpLabel = UILabel()
    let tmpButton = UIButton()
    let createUserButton = UIButton()
    let loginUserButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        

        tmpLabel.text = oAuthTokenStorage.token
        tmpLabel.font = .Regular.large
        tmpLabel.numberOfLines = 3
        tmpLabel.layer.borderWidth = 2
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tmpLabel)
        tmpLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tmpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        

        tmpButton.setTitle("GetFriends", for: .normal)
        tmpButton.setTitleColor(.black, for: .normal)
        tmpButton.addTarget(self, action: #selector(getFriends), for: .touchUpInside)
        tmpButton.layer.borderWidth = 3
        tmpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tmpButton)
        tmpButton.topAnchor.constraint(equalTo: tmpLabel.bottomAnchor, constant: 20).isActive = true
        tmpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tmpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tmpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        createUserButton.setTitle("Create User", for: .normal)
        createUserButton.layer.borderWidth = 3
        createUserButton.setTitleColor(.black, for: .normal)
        createUserButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createUserButton)
        createUserButton.topAnchor.constraint(equalTo: tmpButton.bottomAnchor, constant: 20).isActive = true
        createUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createUserButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        createUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        loginUserButton.setTitle("Login User", for: .normal)
        loginUserButton.layer.borderWidth = 3
        loginUserButton.setTitleColor(.black, for: .normal)
        loginUserButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        loginUserButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginUserButton)
        loginUserButton.topAnchor.constraint(equalTo: createUserButton.bottomAnchor, constant: 20).isActive = true
        loginUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginUserButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginUserButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc
    private func getFriends() {
        getFriendsNetworkService.getFriends() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print("[net] getFriendsNetworkService.getFriends() data: \(data)")
                if let friend = data.first {
                    self.tmpLabel.text = "\(friend.id)"
                } else {
                    self.tmpLabel.text = "Друзей нет"
                }
            case let .failure(error):
                self.tmpLabel.text = error.localizedDescription
                print("[net]  getFriendsNetworkService.getFriends() error: \(error) error text: \(error.localizedDescription)")
            }
        }
    }
    
    
    @objc
    private func createUser() {
        usersServiceProvider.createUser(first_name: self.firstName,
                                        last_name: self.lastName,
                                        email: self.email,
                                        password: self.password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print("[net]  usersServiceProvider.createUser() data: \(data)")
                self.tmpLabel.text = "Created user '\(data.first_name)'"
    
            case let .failure(error):
                self.tmpLabel.text = error.localizedDescription
                print("[net]   usersServiceProvider.createUser() error: \(error) error text: \(error.localizedDescription)")
            }
        }
    }
    
    @objc
    private func loginUser() {
        usersServiceProvider.userLogin(email: self.email,
                                       password: self.password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print("[net]  usersServiceProvider.userLogin() data: \(data)")
                self.tmpLabel.text = "Created user '\(data.auth_token)'"
                
    
            case let .failure(error):
                self.tmpLabel.text = error.localizedDescription
                print("[net]   usersServiceProvider.createUser() error: \(error) error text: \(error.localizedDescription)")
            }
        }
    }
        
}

