import Foundation

extension String {
    
    public struct ActualOrders {}
    public struct ActualOrderInfo {}
    
}

extension String.ActualOrders {
    
    public struct Button {}
    public struct EmergencyButton {}
    public struct Title {}
    
}

extension String.ActualOrderInfo {
    
    public struct Button {
        
        public struct EstimateCostsButton {}
        public struct OpenOrderServiceButton {}
        
    }
    
    public struct Title {}
}

extension String.ActualOrders.Title {
    
    static var title: String {
        return "Актуальные заказы"
    }
    
}

extension String.ActualOrders.Button {
    
    static var title: String {
        return "Обновить"
    }
    
}

extension String.ActualOrders.EmergencyButton {
    
    static var title: String {
        return "Обновить"
    }
    
}

extension String.ActualOrderInfo.Title {
    
    static var title: String {
        return "Заказ"
    }
    
}

extension String.ActualOrderInfo.Button.EstimateCostsButton {
    
    static var title: String {
        return "Оценить стоимость"
    }
    
}

extension String.ActualOrderInfo.Button.OpenOrderServiceButton {
    
    static var title: String {
        return "Открыть заказ"
    }
    
}
