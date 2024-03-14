import UIKit

public class TabBarItem: UITabBarItem {
    @IBInspectable public var tintColor: UIColor?
    @IBInspectable public var rightToLeft:Bool = false
}

public class CBTabBarButton: UIControl {
    
    var rightToLeft:Bool = false
    private var _isSelected: Bool = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            tabImage.image = currentImage
            tabLabel.text = item?.title
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            if _isSelected {
                tabImage.tintColor = tintColor
            }
            tabLabel.textColor = tintColor
            tabBg.backgroundColor = tintColor.withAlphaComponent(0.2)
        }
    }
    
    private var tabImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.setContentHuggingPriority(.required, for: .vertical)
        image.setContentCompressionResistancePriority(.required, for: .horizontal)
        image.setContentCompressionResistancePriority(.required, for: .vertical)
        return image
    }()
    
    private var tabLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private var tabBg: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let bgHeight: CGFloat = 44.0
    private var csFoldedBgTrailing: NSLayoutConstraint!
    private var csUnfoldedBgTrailing: NSLayoutConstraint!
    private var csFoldedLblLeading: NSLayoutConstraint!
    private var csUnfoldedLblLeading: NSLayoutConstraint!
    
    private var foldedConstraints: [NSLayoutConstraint] {
        return [csFoldedLblLeading, csFoldedBgTrailing]
    }
    
    private var unfoldedConstraints: [NSLayoutConstraint] {
        return [csUnfoldedLblLeading, csUnfoldedBgTrailing]
    }
    
    private func addView() {
        [tabBg, tabImage, tabLabel].forEach(addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func configureSubviews() {
        NSLayoutConstraint.activate([
            tabBg.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBg.centerYAnchor.constraint(equalTo: centerYAnchor),
            tabBg.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabBg.heightAnchor.constraint(equalToConstant: bgHeight)
        ])
        if rightToLeft {
            NSLayoutConstraint.activate([
                tabImage.trailingAnchor.constraint(equalTo: tabBg.trailingAnchor, constant: -bgHeight/2.0),
                tabImage.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor),
                tabLabel.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor)
            ])
            csFoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabBg.trailingAnchor)
            csUnfoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/4.0)
            csFoldedBgTrailing = tabImage.trailingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/2.0)
            csUnfoldedBgTrailing = tabLabel.trailingAnchor.constraint(equalTo: tabImage.leadingAnchor, constant: -bgHeight/2.0)
        } else {
            NSLayoutConstraint.activate([
                tabImage.leadingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/3.0),
                tabImage.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor),
                tabLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
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
            self.tabLabel.textColor = .black
        }
        UIView.transition(with: tabImage, duration: duration, options: [.transitionCrossDissolve], animations: {
            self.tabImage.tintColor = .lightGray
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
            self.tabLabel.textColor = .black
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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        tabBg.layer.cornerRadius = 12
    }
}
