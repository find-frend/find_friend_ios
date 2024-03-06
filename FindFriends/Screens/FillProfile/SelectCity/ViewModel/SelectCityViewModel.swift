import UIKit

protocol SelectCityViewModelProtocol {
    var cities: [String] { get set }
}

final class SelectCityViewModel: SelectCityViewModelProtocol {
    
var cities = ["Астана", "Москва", "Санкт-Питербург", "Нью-Йорк", "Лондон", "Париж"]
    
}
