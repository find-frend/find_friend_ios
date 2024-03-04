//
//  BaseFillProfileView.swift
//  FindFriends
//
//  Created by Vitaly on 04.03.2024.
//

import UIKit


class BaseFillProfileView: UIView {
    
    private let nextButtonText = "Далее"
    private let passButtonText = "Пропустить"
    
    public lazy var navigationBarView: NavigationBarView = {
        var navigationBarView = NavigationBarView()
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        navigationBarView.backgroundColor = .secondaryOrange
        navigationBarView.layer.cornerRadius = 2
        navigationBarView.layer.masksToBounds = true
        return navigationBarView
    }()
    
    public lazy var screenHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Regular.header24
        label.textColor = .primeDark
        return label
    } ()
    
    public lazy var screenSubheader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Regular.medium16
        label.textColor = .standardGreyWireframe
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    } ()
    
    public lazy var nextButton = PrimeOrangeButton(text: nextButtonText)
    public lazy var passButton: UIButton = {
        var button = UIButton()
        button.setTitle(passButtonText, for: .normal)
        button.titleLabel?.font =  UIFont.Regular.medium
        button.setTitleColor(.buttonBlack, for: .normal)
        
        return button
    }()
    
    // если subheader пустой, то его на скрине не будет
    required init(header: String, screenPosition: Int, subheader: String = "") {
        super.init(frame: .zero)
    
        self.backgroundColor = .backgroundLaunchScreen
        
        screenHeader.text = header //"Интересы"
        screenSubheader.text = subheader //"Выберете свои увлечения, чтобы найти единомышленников"
        
        navigationBarView.setRating(navBarPosition: screenPosition)
        
        setConstraits()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraits() {
        
        self.addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            navigationBarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            navigationBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            navigationBarView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
       
        self.addSubview(screenHeader)
        screenHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        screenHeader.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 12).isActive = true
        screenHeader.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        if screenSubheader.text?.isEmpty != nil  {
            self.addSubview(screenSubheader)
            screenSubheader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            screenSubheader.topAnchor.constraint(equalTo: screenHeader.bottomAnchor).isActive = true
            screenSubheader.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 46.5).isActive = true
            screenSubheader.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -46.5).isActive = true
        }
        
        self.addSubview(nextButton)
        nextButton.setEnabled(true)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48) .isActive = true
        
        self.addSubview(passButton)
        passButton.translatesAutoresizingMaskIntoConstraints = false
        passButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 16).isActive = true
        passButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 125.5).isActive = true
        passButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -125.5).isActive = true
        passButton.heightAnchor.constraint(equalToConstant: 48) .isActive = true
        
        

 
    }
    
}
