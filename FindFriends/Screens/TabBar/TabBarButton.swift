import UIKit

public class TabBarItem: UITabBarItem {
    @IBInspectable public var tintColor: UIColor?
    @IBInspectable public var rightToLeft:Bool = false
}

public class CBTabBarButton: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addView()
        configureSubviews()
    }
    
    init(item: UITabBarItem) {
        super.init(frame: .zero)
        tabImage = UIImageView(image: item.image)
        defer {
            self.item = item
            addView()
            configureSubviews()
        }
    }
    
    override public var isSelected: Bool {
        get {
            return _isSelected
        }
        set {
            guard newValue != _isSelected else {
                return
            }
            setSelected(newValue)
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            if _isSelected {
                tabImage.tintColor = .black
            }
            tabLabel.textColor = .black
            tabBg.backgroundColor = tintColor.withAlphaComponent(0.2)
        }
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        tabBg.layer.cornerRadius = tabBg.bounds.height / 3.0
    }
    
    private var rightToLeft:Bool = false
    private var _isSelected: Bool = false
    private var tabImage = UIImageView()
    private var tabLabel = UILabel()
    private var tabBg = UIView()
    private let bgHeight: CGFloat = 38.0
    private var csFoldedBgTrailing: NSLayoutConstraint!
    private var csUnfoldedBgTrailing: NSLayoutConstraint!
    private var csFoldedLblLeading: NSLayoutConstraint!
    private var csUnfoldedLblLeading: NSLayoutConstraint!
    
    
    private var currentImage: UIImage? {
        var maybeImage: UIImage?
        if _isSelected {
            maybeImage = item?.selectedImage ?? item?.image
        } else {
            maybeImage = item?.image
        }
        guard let image = maybeImage else {
            return nil
        }
        return image.renderingMode == .automatic ? image.withRenderingMode(.alwaysTemplate) : image
    }
    
    public var item: UITabBarItem? {
        didSet {
            tabLabel.text = item?.title
            tabImage.image = currentImage
        }
    }
    
    private var foldedConstraints: [NSLayoutConstraint] {
        return [csFoldedLblLeading, csFoldedBgTrailing]
    }
    
    private var unfoldedConstraints: [NSLayoutConstraint] {
        return [csUnfoldedLblLeading, csUnfoldedBgTrailing]
    }
    
    private func addView() {
        [tabBg, tabLabel, tabImage].forEach(setupView(_:))
    }
    
    
    private func configureSubviews() {
        tabImage.contentMode = .center
        tabLabel.font = UIFont.systemFont(ofSize: 14)
        tabLabel.adjustsFontSizeToFitWidth = true
        tabBg.isUserInteractionEnabled = false
        tabImage.setContentHuggingPriority(.required, for: .horizontal)
        tabImage.setContentHuggingPriority(.required, for: .vertical)
        tabImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        tabImage.setContentCompressionResistancePriority(.required, for: .vertical)
        
        tabBg.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabBg.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tabBg.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabBg.heightAnchor.constraint(equalToConstant: bgHeight).isActive = true
        
        if rightToLeft {
            tabImage.trailingAnchor.constraint(equalTo: tabBg.trailingAnchor, constant: -bgHeight/2.0).isActive = true
            tabImage.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor).isActive = true
            tabLabel.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor).isActive = true
            csFoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabBg.trailingAnchor)
            csUnfoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/4.0)
            csFoldedBgTrailing = tabImage.trailingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/2.0)
            csUnfoldedBgTrailing = tabLabel.trailingAnchor.constraint(equalTo: tabImage.leadingAnchor, constant: -bgHeight/2.0)
        } else {
            tabImage.leadingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/2.0).isActive = true
            tabImage.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor).isActive = true
            tabLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            csFoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
            csUnfoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabImage.trailingAnchor, constant: bgHeight/4.0)
            csFoldedBgTrailing = tabImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bgHeight/2.0)
            csUnfoldedBgTrailing = tabLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bgHeight/2.0)
        }
        
        fold()
        setNeedsLayout()
    }
    
    private func fold(animationDuration duration: Double = 0.0) {
        unfoldedConstraints.forEach{ $0.isActive = false }
        foldedConstraints.forEach{ $0.isActive = true }
        UIView.animate(withDuration: duration) {
            self.tabBg.alpha = 0.0
        }
        UIView.animate(withDuration: duration * 0.4) {
            self.tabLabel.alpha = 0.0
        }
        UIView.transition(with: tabImage, duration: duration, options: [.transitionCrossDissolve], animations: {
            self.tabImage.tintColor = .systemGray2
        }, completion: nil)
        
    }
    
    private func unfold(animationDuration duration: Double = 0.0) {
        foldedConstraints.forEach{ $0.isActive = false }
        unfoldedConstraints.forEach{ $0.isActive = true }
        UIView.animate(withDuration: duration) {
            self.tabBg.alpha = 1.0
        }
        UIView.animate(withDuration: duration * 0.5, delay: duration * 0.5, options: [], animations: {
            self.tabLabel.alpha = 1.0
        }, completion: nil)
        UIView.transition(with: tabImage, duration: duration, options: [.transitionCrossDissolve], animations: {
            self.tabImage.tintColor = .black
        }, completion: nil)
    }
    
    public func setSelected(_ selected: Bool, animationDuration duration: Double = 0.0) {
        _isSelected = selected
        UIView.transition(with: tabImage, duration: 0.05, options: [.beginFromCurrentState], animations: {
            self.tabImage.image = self.currentImage
        }, completion: nil)
        if selected {
            unfold(animationDuration: duration)
        } else {
            fold(animationDuration: duration)
        }
    }
}
