import Foundation

final class DeliveryRequestPresenter {
    
    func makeDeliveryRequest(info: [String]) -> Bool? {
        var type = ""
        var rest = ""
        if info[2] == "Пеший курьер" {
            type = "man"
        }
        else {
            type = "car"
        }
        
        if info[3] == "Мозаика" {
            rest = "M"
        }
        else {
            rest = "K"
        }
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "tomilov-business.ru"
        components.path = "/api/make-delivery-request"
        components.queryItems = [
            URLQueryItem(name: "order_id", value: info[0]),
            URLQueryItem(name: "delivery_service", value: info[1]),
            URLQueryItem(name: "transport_type", value: type),
            URLQueryItem(name: "rest_id", value: rest)
        ]
        
        guard let url = components.url else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            
            guard let info = json?["info"] as? NSDictionary,
                  let isOrderCreated = info["isCreated"] as? Bool else {
                return nil
            }
            
            return isOrderCreated
        }
        catch {
            return nil
        }
    }
}
