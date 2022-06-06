import Foundation

final class CostsEstimatePresenter {
    
    func getDeliveryEstimationCosts(with orderId: String, completion: @escaping([String]) -> Void) {
        let Url = String(format: Links.estimateCosts.rawValue + "?order_id=" + orderId)
        guard let serviceUrl = URL(string: Url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS", forHTTPHeaderField: "deviceType")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    var costs = [String]()
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let order = json as? NSDictionary,
                          let costsInfo = order["costsInfo"] as? NSDictionary else {
                        return
                    }
                    
                    guard let dv_cost_k_car = costsInfo["dv_cost_k_car"] as? String,
                          let dv_cost_k_man = costsInfo["dv_cost_k_man"] as? String,
                          let dv_cost_m_car = costsInfo["dv_cost_m_car"] as? String,
                          let dv_cost_m_man = costsInfo["dv_cost_m_man"] as? String else {
                        completion(costs)
                        return
                    }
                    
                    costs.append(dv_cost_k_car)
                    costs.append(dv_cost_k_man)
                    costs.append(dv_cost_m_car)
                    costs.append(dv_cost_m_man)
                    
                    guard let yx_cost_k_car = costsInfo["yx_cost_k_car"] as? String,
                          let yx_cost_k_man = costsInfo["yx_cost_k_man"] as? String,
                          let yx_cost_m_car = costsInfo["yx_cost_m_car"] as? String,
                          let yx_cost_m_man = costsInfo["yx_cost_m_man"] as? String else {
                        completion(costs)
                        return
                    }
                    
                    costs.append(yx_cost_k_car)
                    costs.append(yx_cost_k_man)
                    costs.append(yx_cost_m_car)
                    costs.append(yx_cost_m_man)
                    
                    completion(costs)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}
