import Foundation

final class SettingsPresenter {
    
    func makePhoneCall(_ phone: String, _ comletion: @escaping (URL) -> Void) {
        if let phoneURL = URL(string: "tel://\(phone)") {
            comletion(phoneURL)
        }
    }
    
}
