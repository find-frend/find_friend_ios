//
//  SelectInterestsView.swift
//  FindFriends
//
//  Created by Vitaly on 01.03.2024.
//

import UIKit

class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 12.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 17.0, bottom: 0.0, right: 17.0)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}


class SelectInterestsBaseViewController: UIViewController {


    private var selectInterestsView = SelectInterestsView()
    
    
    override func loadView() {
        view = selectInterestsView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}







