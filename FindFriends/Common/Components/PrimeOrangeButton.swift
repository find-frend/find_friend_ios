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
        titleLabel?.font = .Semibold.medium
        setTitleColor(.white, for: .normal)
        backgroundColor = .lightOrange
        setTitle(text, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
        backgroundColor = enabled ? .mainOrange : .lightOrange
    }
}
