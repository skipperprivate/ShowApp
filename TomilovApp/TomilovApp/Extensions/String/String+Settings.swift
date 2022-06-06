import Foundation

extension String {
    
    public struct Settings {}
    
}

extension String.Settings {
    
    public struct Phone {
        
        public struct PhoneNumberOwners {}
        public struct PhoneNumbers {}
        
    }
    
    public struct Title {}
    
}

extension String.Settings.Title {
    
    static var title: String {
        return "Настройки"
    }
    
}

extension String.Settings.Phone.PhoneNumberOwners {
    
    static var yandexFood: String {
        return "Яндекс Еда"
    }
    
    static var yandexClient1: String {
        return "Яндекс Клиент 1"
    }
    
    static var yandexClient2: String {
        return "Яндекс Клиент 2"
    }
    
}

extension String.Settings.Phone.PhoneNumbers {
    
    static var yandexFood: String {
        return "+7(800)600-13-10"
    }
    
    static var yandexClient1: String {
        return "+7(495)118-38-30"
    }
    
    static var yandexClient2: String {
        return "+7(495)118-30-86"
    }
    
}
