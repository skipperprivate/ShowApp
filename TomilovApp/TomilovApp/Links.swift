import Foundation

enum Links: String {
    case yandexFood = "https://vendor.eda.yandex/active/"
    case mBron = "https://m-bron.ru/cabinet/orders"
    case getActualOrders = "http://127.0.0.1:8000/api/"
    case makeEmergencyUpdate = "http://127.0.0.1:8000/api/emergency-update"
    case history = "http://127.0.0.1:8000/api/history"
    case estimateCosts = "http://127.0.0.1:8000/api/estimate-costs"
    case makeDeliveryRequest = "http://127.0.0.1:8000/api/make-delivery-request"
    case getActualOrderInfo = "http://127.0.0.1:8000/api/get-actual-order-info"
    case getHistoryOrderInfo = "http://127.0.0.1:8000/api/get-history-order-info"
}
