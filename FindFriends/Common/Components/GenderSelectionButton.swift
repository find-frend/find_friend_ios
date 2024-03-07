//
//  GenderSelectionButton.swift
//  FindFriends
//
//  Created by Ognerub on 3/5/24.
//

import UIKit

final class GenderSelectionButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.textGray, for: .normal)
        setTitleColor(.primeDark, for: .highlighted)
        contentVerticalAlignment = .bottom
        layer.cornerRadius = 20
        layer.masksToBounds = true
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 17, trailing: 0)
        configuration.baseBackgroundColor = .white
        self.configuration = configuration
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isSelected(_ enabled: Bool) {
        isSelected = enabled
        setTitleColor(enabled ? .primeDark : .textGray, for: .selected)
        configuration?.baseBackgroundColor = enabled ? .buttonGray : .white
    }
}
