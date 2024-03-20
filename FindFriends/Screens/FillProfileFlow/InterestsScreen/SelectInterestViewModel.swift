//
//  SelectInterestViewModel.swift
//  FindFriends
//
//  Created by Vitaly on 06.03.2024.
//

import Foundation
typealias Interest = InterestsdDto

protocol SelectInterestsViewModelDelegate: AnyObject {
    func didUpdateInterests()
}

protocol SelectInterestsViewModelProtocol {
    var delegate: SelectInterestsViewModelDelegate? {get set}
    var interests: [Interest] {get} // список всех интересов
    var showInterests: [Interest] {get} // список интересов для показа
    
    func getInterests()
}

final class SelectInterestsViewModel: SelectInterestsViewModelProtocol {
    private var defaultCountIntrerests = 15
    
    weak var delegate: SelectInterestsViewModelDelegate?
    
    private (set) var interestsProvider: InterestsServiceProviderProtocol?
    
    private (set) var showInterests: [Interest] = [] {
        didSet {
            delegate?.didUpdateInterests()
        }
    }


    private (set) var interests: [Interest] = [] {
        didSet {
            showInterests = Array(interests.prefix(upTo: min(interests.count, defaultCountIntrerests)))
        }
    }
    
    init(interestsProvider: InterestsServiceProviderProtocol? = InterestsServiceProvider()) {
        self.interestsProvider = interestsProvider
        
    }
    
    func getInterests() {
        interestsProvider?.getInterests() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.interests = data.compactMap( { Interest($0) })   // конечно можно написать просто   self.currencies = data, но так как-то "правильнее"
            case let .failure(error):
                print("getInterests error: \(error)")
            }
        }
    }
    
}
