//
//  NavigationBarView.swift
//  FindFriends
//
//  Created by Vitaly on 04.03.2024.
//

import UIKit




// КАК ИСПОЛЬЗОВАТЬ
// Размер по умолчанию 5 звезд
// Обязательны картинки в ресурсах .star : .starGray
// Использовать так.

// ratingView = RatingView()
//
// ratingView.setRating(rank: 3)  -  установить 3 золотые звезды
//
//+ констрейнты для ratingView


import UIKit

final class NavigationBarView: UIStackView {
    let sizeBar: Int
    
    init(sizeBar: Int = 5) {
        self.sizeBar = sizeBar
        
        super.init(frame: .zero)
        
        self.axis  = NSLayoutConstraint.Axis.horizontal
        self.distribution  = UIStackView.Distribution.equalSpacing
        self.alignment = UIStackView.Alignment.leading
        self.spacing = 2
        self.translatesAutoresizingMaskIntoConstraints = false
      
        
        self.inputView?.backgroundColor = .green

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(navBarPosition: Int) {
        var computedNavBarPosition = navBarPosition
        if navBarPosition < 1 ||  navBarPosition > sizeBar  {
            computedNavBarPosition = 0
        }
        
        clear()
        for index in 1...sizeBar {
            self.addArrangedSubview(createStarView(index <= computedNavBarPosition ? true : false))
        }
    }
    
    private func clear() {
        for view in self.subviews {
            self.removeArrangedSubview(view)
        }
    }

    private func createStarView(_ active: Bool) -> UIView {
        let subView = UIView()
        subView.backgroundColor = active ? .mainOrange : .secondaryOrange
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        subView.widthAnchor.constraint(equalToConstant: 53.54).isActive = true
        subView.layer.cornerRadius = 2
        subView.layer.masksToBounds = true

        return subView
    }
}
