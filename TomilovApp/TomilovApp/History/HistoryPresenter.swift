import Foundation

final class HistoryPresenter {
    
    // MARK: - Private types

    private typealias History = String.History
    
    func getHistory(period: String) -> [[String]]? {
        var finalPeriod = "0"
        
        switch period {
        case History.Picker.yesterday:
            finalPeriod = "0"
            
        case History.Picker.week:
            finalPeriod = "6"
            
        case History.Picker.month:
            finalPeriod = "30"
            
        default:
            finalPeriod = "0"
        }
        
        guard let url = URL(string: Links.history.rawValue + "?period=" + finalPeriod) else {
            return nil
        }
        
        do {
            var orders = [[String]]()
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            
            guard let ordersInfo = json?["history"] as? NSArray else {
                return nil
            }
            
            for order in ordersInfo {
                guard let order = order as? NSDictionary,
                    let id = order["id"] as? String,
                    let clientAddress = order["client_address"] as? String,
                    let clientInfo = order["client"] as? String,
                    let channel = order["channel"] as? String,
                    let totalSum = order["total"] as? String,
                    let status = order["status"] as? String else {
                    return nil
                }
                orders.append([id, clientInfo, clientAddress, channel, totalSum, status])
            }
            
            return orders
        }
        catch {
            return nil
        }
    }
    
}
