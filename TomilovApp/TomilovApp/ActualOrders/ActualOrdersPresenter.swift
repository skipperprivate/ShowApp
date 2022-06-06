import Foundation

final class ActualOrdersPresenter {
    
    func getActualOrders() -> [[String]]? {
        print("aaaaa")
        guard let url = URL(string: Links.getActualOrders.rawValue) else {
            return nil
        }
        
        do {
            var orders = [[String]]()
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            
            guard let ordersInfo = json?["ordersInfo"] as? NSArray else {
                return nil
            }
            
            for order in ordersInfo {
                guard let order = order as? NSDictionary,
                    let id = order["id"] as? String,
                    let clientAddress = order["client_address"] as? String,
                    let clientInfo = order["client"] as? String,
                    let status = order["status"] as? String,
                    let deliveryService = order["delivery_service"] as? String else {
                    return nil
                }
                var deliveryType = ""
                switch deliveryService {
                case let type where type.contains("yandex"):
                    deliveryType = "yndx"
                    
                case let type where type.contains("dostavista"):
                    deliveryType = "dstvst"
                    
                default:
                    deliveryType = ""
                }
                orders.append([id, clientInfo, clientAddress, status, deliveryType])
            }
            
            return orders
        }
        catch {
            return nil
        }
    }
    
    func makeEmergencyUpdate() -> [[String]]? {
        guard let url = URL(string: Links.makeEmergencyUpdate.rawValue) else {
            return nil
        }
        
        do {
            var orders = [[String]]()
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            
            guard let ordersInfo = json?["ordersInfo"] as? NSArray else {
                return nil
            }
            
            for order in ordersInfo {
                guard let order = order as? NSDictionary,
                    let id = order["id"] as? String,
                    let clientAddress = order["client_address"] as? String,
                    let clientInfo = order["client"] as? String,
                    let status = order["status"] as? String,
                    let deliveryService = order["delivery_service"] as? String else {
                    return nil
                }
                var deliveryType = ""
                switch deliveryService {
                case let type where type.contains("yandex"):
                    deliveryType = "yndx"
                    
                case let type where type.contains("dostavista"):
                    deliveryType = "dstvst"
                    
                default:
                    deliveryType = ""
                }
                orders.append([id, clientInfo, clientAddress, status, deliveryType])
            }
            
            return orders
        }
        catch {
            return nil
        }
    }
    
}
