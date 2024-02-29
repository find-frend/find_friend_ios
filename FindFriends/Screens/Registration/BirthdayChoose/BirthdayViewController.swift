//
//  BirthdayViewController.swift
//  FindFriends
//
//  Created by Aleksey Kolesnikov on 28.02.2024.
//

import UIKit

final class BirthdayViewController: UIViewController {
    private var birthdayView: BirthdayView
    
    override func loadView() {
        view = birthdayView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        birthdayView.underLineTextField()
    }
    
    init(birthdayView: BirthdayView) {
        self.birthdayView = birthdayView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
