import UIKit

protocol CityViewModelProtocol {
    var citiesList: [String] { get set }
    var filteredCitiesList: [String] {get set }
}

final class CityViewModel: CityViewModelProtocol {
    var filteredCitiesList: [String] = []
    var citiesList = ["Астана", "Москва", "Санкт-Петербург", "Нью-Йорк", "Лондон", "Париж"]
}
