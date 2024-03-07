import UIKit

final class SearchButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchButton() {
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        tintColor = .placeholder
        widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
