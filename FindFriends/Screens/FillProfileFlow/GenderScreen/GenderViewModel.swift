//
//  GenderViewModel.swift
//  FindFriends
//
//  Created by Ognerub on 3/4/24.
//

import Foundation

final class GenderViewModel {
    @Published var selectedGender: SelectedGender?
    
    func change(gender: SelectedGender) {
        switch gender {
        case.man:
            selectedGender = .man
        case .woman:
            selectedGender = .woman
        }
    }
    
    enum SelectedGender {
        case man
        case woman
    }
}
