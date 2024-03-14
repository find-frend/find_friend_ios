//
//  TagsCollectionView.swift
//  FindFriends
//
//  Created by Vitaly on 02.03.2024.
//

import UIKit




final class tagsCollectionViewCell: UICollectionViewCell,  ReuseIdentifying  {
    
    var tagLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .selectedTag : .backgroundLaunchScreen
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .backgroundLaunchScreen
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.borderGray.cgColor
        contentView.layoutMargins  = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        tagLabel.textAlignment = .center
        tagLabel.font = UIFont.Regular.medium16
        contentView.addSubview(tagLabel)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false

        tagLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



