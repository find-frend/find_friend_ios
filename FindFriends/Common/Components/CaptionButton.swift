//
//  CaptionButton.swift
//  FindFriends
//
//  Created by Вадим Шишков on 15.02.2024.
//

import UIKit

final class CaptionButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        titleLabel?.font = .Semibold.medium
        setTitleColor(.primeDark, for: .normal)
        backgroundColor = .clear
        setTitle(text, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
