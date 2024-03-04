//
//  SelectInterestsBaseView.swift
//  FindFriends
//
//  Created by Vitaly on 04.03.2024.
//

import UIKit

struct CollectionLayout {
    static let trailingOffsetCell: Double = 16
    static let leadingOffsetCell: Double = 16
    static let topOffsetCell: Double = 20
    static let heightOfCell: Double = 46
    static let spaceBetweenColumns: Double = 7
    static let spaceBetweenRows: Double = 15
    static let countOfColumsCell: Double = 2
}

final class  SelectInterestsView: BaseFillProfileView {
    
    private let tags = ["Бары и клубы", "Рыбалка", "Квесты", "Иностранные языки", "Литература", "Йога", "Настольные игры", "Сноуборд", "Мафия", "Фигурное катание", "Живопись", "Путешествия", "Шахматы"]
    
    private lazy var tagsSearchBar: UISearchBar = {
        var bar  = UISearchBar()
        bar.placeholder = "Поиск интересов"
        bar.searchBarStyle = UISearchBar.Style.minimal
        
        bar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск интересов", attributes: [
            .foregroundColor: UIColor.searchBar,
            .font: UIFont.Regular.medium
        ])
        
        bar.backgroundColor = .backgroundLaunchScreen
        bar.searchTextField.textColor = UIColor.searchBar

        for subview in bar.searchTextField.subviews {
            subview.backgroundColor = .clear
            subview.alpha = 0
        }
        
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()
    
    private lazy var tagsCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .backgroundLaunchScreen
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    required init() {
        super.init(header: "Интересы", screenPosition: 3, subheader: "Выберете свои увлечения, чтобы найти единомышленников")
        
        let columnLayout = CustomViewFlowLayout()
        columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagsCollectionView.collectionViewLayout = columnLayout
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        tagsCollectionView.register(tagsCollectionViewCell.self)
        
        
        self.addSubview(tagsSearchBar)
        NSLayoutConstraint.activate([
            tagsSearchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tagsSearchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tagsSearchBar.topAnchor.constraint(equalTo: self.screenSubheader.bottomAnchor, constant: 24),
            tagsSearchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(tagsCollectionView)
        NSLayoutConstraint.activate([
            tagsCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tagsCollectionView.topAnchor.constraint(equalTo: self.tagsSearchBar.bottomAnchor),
            tagsCollectionView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(header: String, screenPosition: Int, subheader: String = "") {
        fatalError("init(header:screenPosition:subheader:) has not been implemented")
    }
}

extension SelectInterestsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: tagsCollectionViewCell = tagsCollectionView.dequeueReusableCell(indexPath: indexPath)

        cell.tagLabel.text = tags[indexPath.row]
        return cell
    }
}


extension SelectInterestsView: UICollectionViewDelegateFlowLayout {

    // отступ между яейками в одном ряду  (горизонтальные отступы)   // отвечает за горизонтальные отступы между ячейками.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionLayout.spaceBetweenColumns
    }
    //    // отступы ячеек от краев  коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CollectionLayout.topOffsetCell, left: CollectionLayout.leadingOffsetCell, bottom: 10, right: CollectionLayout.trailingOffsetCell)
    }
    // отвечает за вертикальные отступы  между яцейками в коллекции;
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionLayout.spaceBetweenRows
    }
    
}

extension SelectInterestsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = tagsCollectionView.cellForItem(at: indexPath) as? tagsCollectionViewCell
        cell?.isSelected = true
        cell?.selectedBackgroundView
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = tagsCollectionView.cellForItem(at: indexPath) as? tagsCollectionViewCell
       // cell?.selectTag(isSelected: false)
        cell?.isSelected = false
    }
}

