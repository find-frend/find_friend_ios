//
//  GenderSelectionViewController.swift
//  FindFriends
//
//  Created by Ognerub on 3/3/24.
//

import UIKit

final class GenderSelectionViewController: UIViewController {
    
    var genderView: GenderView
    
    init(genderView: GenderView) {
        self.genderView = genderView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = genderView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

