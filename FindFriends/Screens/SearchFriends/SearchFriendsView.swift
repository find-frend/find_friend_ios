//
//  SearchFriendsView.swift
//  FindFriends
//
//  Created by Вадим Шишков on 29.02.2024.
//

import UIKit

protocol SearchFriendsViewDelegate: AnyObject {
    
}

final class SearchFriendsView: UIView {
    weak var delegate: SearchFriendsViewDelegate?
    private let viewModel = SearchFriendsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundMain
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .backgroundMain
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchFriendCell.self, forCellReuseIdentifier: SearchFriendCell.reuseIdentifier)
    }
    
    private func setupLayout() {
        addSubviewWithoutAutoresizingMask(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchFriendsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchFriendCell.reuseIdentifier,
            for: indexPath) as? SearchFriendCell 
        else { return UITableViewCell() }
        cell.configure(with: viewModel.friends[indexPath.row])
        return cell
    }
}

extension SearchFriendsView: UITableViewDelegate {
    
}
