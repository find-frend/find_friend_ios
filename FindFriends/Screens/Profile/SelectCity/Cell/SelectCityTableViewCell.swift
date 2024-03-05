import UIKit

final class SelectCityTableViewCell: UITableViewCell {
    static let identifier = "SelectCityCell"
    
    override func didMoveToSuperview() {
        selectedBackgroundView?.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            checkMark.setImage(UIImage(named: "selectCity"), for: .normal)
            checkMark.tintColor = UIColor.lightOrange
        } else {
            checkMark.setImage(UIImage(named: "nonSelectCity"), for: .normal)
            checkMark.tintColor = UIColor.black
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SelectCityTableViewCell.identifier)
        addView()
        applyConstraints()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Астана"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    } ()
    
    private lazy var checkMark: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "nonSelectCity"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    private func addView() {
        [label, checkMark].forEach(addSubviewWithoutAutoresizingMask(_:))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34),
            checkMark.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -10),
            checkMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
