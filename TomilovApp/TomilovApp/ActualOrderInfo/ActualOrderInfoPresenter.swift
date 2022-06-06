import Foundation

final class ActualOrderInfoPresenter {
    
    // MARK: - Public methods
    
    public func openOrderService(_ id: String, _ comletion: @escaping (URL) -> Void) {
        if let serviceURL = URL(string: Links.yandexFood.rawValue + id) {
            comletion(serviceURL)
        }
    }
    
    public  func getActualOrderInfo(_ id: String) -> [String]? {
        guard let url = URL(string: Links.getActualOrderInfo.rawValue + "?order_id=" + id) else {
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
                    let totalSum = order["total"] as? String,
                    let status = order["status"] as? String,
                    let entrance = order["Entrance"] as? String,
                    let intercom = order["Intercom"] as? String,
                    let floor = order["Floor"] as? String,
                    let flat = order["Flat"] as? String,
                    let deliveryService = order["delivery_service"] as? String else {
                    return nil
                }
                orders.append(id)
                orders.append(clientInfo)
                orders.append(clientAddress)
                let addressInfo = "Подъезд: \(entrance), " + "Домофон: \(intercom), " + "Этаж: \(floor), " + "Кв/офис: \(flat)"
                orders.append(addressInfo)
                orders.append(channel)
                orders.append(totalSum)
                orders.append(status)
                orders.append(deliveryService)
            }
            
            return orders
        }
        catch {
            return nil
        }
    }
    
    public func makePhoneCall(_ clientInfo: String, _ comletion: @escaping (URL) -> Void) {
        let phoneInfo = formNumberByYandexOrder(clientInfo)
        // https://stackoverflow.com/questions/37973246/how-to-call-an-extension-after-dialing-a-phone-number-in-swift
        if let phoneURL = URL(string: "tel://\(phoneInfo[0]),\(phoneInfo[1])") {
            comletion(phoneURL)
        }
    }
    
    public func goToDeliveryService(_ deliveryService: String, _ comletion: @escaping (URL) -> Void) {
        if let deliveryServiceURL = URL(string: deliveryService) {
            comletion(deliveryServiceURL)
        }
    }
    
    // MARK: - Private methods
    
    private func formNumberByYandexOrder(_ info: String) -> [String] {
        var phoneNumbers = ["", ""]
        if let plusIndex = info.index(of: "+") {
            let lastIndex = info.index(plusIndex, offsetBy: 16)
            let phoneSequence = info[plusIndex..<lastIndex]
            let phoneString = String(phoneSequence)
            let phoneTrimmedString = phoneString.replacingOccurrences(of: " ", with: "-")
            phoneNumbers[0] = phoneTrimmedString
            phoneNumbers[1] = String(info.suffix(5))
        }
        
        return phoneNumbers
    }
    
}
