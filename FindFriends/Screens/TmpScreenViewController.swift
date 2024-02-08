//
//  TmpScreenViewController.swift
//  FindFriends
//
//  Created by Vitaly on 08.02.2024.
//

import UIKit

class TmpScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let tmpLabel = UILabel()
        tmpLabel.text = "Временный текст"
        tmpLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tmpLabel)
        tmpLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tmpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}

