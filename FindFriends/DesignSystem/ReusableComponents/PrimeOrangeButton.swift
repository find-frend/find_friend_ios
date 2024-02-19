//
//  PrimeButton.swift
//  FindFriends
//
//  Created by Вадим Шишков on 15.02.2024.
//

import UIKit

final class PrimeOrangeButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        layer.cornerRadius = 10
        titleLabel?.font = Fonts.bodySemibold17
        setTitleColor(Colors.primeWhite, for: .normal)
        backgroundColor = Colors.lightOrange
        setTitle(text, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
