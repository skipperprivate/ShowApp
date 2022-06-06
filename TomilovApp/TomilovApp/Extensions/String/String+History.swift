import Foundation

extension String {
    
    public struct History {}
    public struct HistoryOrderInfo {}
    
}

extension String.History {
    
    public struct Picker {}
    public struct Button {}
    public struct Title {}
    
}

extension String.HistoryOrderInfo {
    
    public struct Button {
        
        public struct OpenOrderServiceButton {}
        
    }
    
    public struct Title {}
}

extension String.History.Title {
    
    static var title: String {
        return "История"
    }
    
}

extension String.History.Button {
    
    static var title: String {
        return "Статистика"
    }
    
}

extension String.History.Picker {
    
    static var yesterday: String {
        return "Вчера"
    }
    
    static var week: String {
        return "Неделя"
    }
    
    static var month: String {
        return "Месяц"
    }
    
}

extension String.HistoryOrderInfo.Title {
    
    static var title: String {
        return "Заказ"
    }
    
}

extension String.HistoryOrderInfo.Button.OpenOrderServiceButton {
    
    static var title: String {
        return "Открыть заказ"
    }
    
}
