import Foundation

final class HistoryOrderInfoPresenter {
    
    // MARK: - Public methods
    
    public func getHistoryOrderInfo(_ id: String) -> [String]? {
        guard let url = URL(string: Links.getHistoryOrderInfo.rawValue + "?order_id=" + id) else {
            return nil
        }
        
        do {
            var orders = [String]()
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            
            guard let ordersInfo = json?["info"] as? NSArray else {
                return nil
            }
            
            for order in ordersInfo {
                guard let order = order as? NSDictionary,
                    let id = order["id"] as? String,
                    let clientAddress = order["client_address"] as? String,
                    let clientInfo = order["client"] as? String,
                    let channel = order["channel"] as? String,
                    let totalSum = order["total"] as? String else {
                    return nil
                }
                orders.append(id)
                orders.append(clientInfo)
                orders.append(clientAddress)
                orders.append(channel)
                orders.append(totalSum)
            }
            
            return orders
        }
        catch {
            return nil
        }
    }
    
}
