//
//  WelcomeViewModel.swift
//  FindFriends
//
//  Created by Victoria Isaeva on 21.03.2024.
//

import Foundation

struct WelcomeModel {
    var firstName: String = ""
}

class WelcomeViewModel {
    var welcomeModel = WelcomeModel()
    //получение имени пользователя
    func fetchUserData(completion: @escaping (Bool) -> Void) {
        let networkClient = DefaultNetworkClient()
        let userRequest = ProfileRequest()
        
        networkClient.send(request: userRequest, type: ProfileDto.self) { result in
            switch result {
            case .success(let userData):
                print("First name: \(userData.firstName)")
                self.welcomeModel.firstName = userData.firstName
                completion(true)
            case .failure(let error):
                print("Ошибка при получении данных пользователя: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
