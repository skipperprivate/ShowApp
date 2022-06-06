import Foundation

extension String {
    
    public struct CostEstimate {}
    
}

extension String.CostEstimate {
    
    public struct DeliveryService {}
    public struct RestaurantAddress {}
    public struct RestaurantAddressFullName {}
    public struct TransportType {}
    public struct Title {}
    
}

extension String.CostEstimate.Title {
    
    static var title: String {
        return "Стоимость доставки"
    }
    
}

extension String.CostEstimate.DeliveryService {
    
    static var yandex: String {
        return "Yandex"
    }
    
    static var dostavista: String {
        return "Dostavista"
    }
    
}

extension String.CostEstimate.RestaurantAddress {
    
    static var kuntsevo: String {
        return "К"
    }
    
    static var mozaika: String {
        return "М"
    }
    
}

extension String.CostEstimate.RestaurantAddressFullName {
    
    static var kuntsevo: String {
        return "Кунцево"
    }
    
    static var mozaika: String {
        return "Мозаика"
    }
    
}

extension String.CostEstimate.TransportType {
    
    static var man: String {
        return "Пеший курьер"
    }
    
    static var car: String {
        return "Легковой автомобиль"
    }
    
}
