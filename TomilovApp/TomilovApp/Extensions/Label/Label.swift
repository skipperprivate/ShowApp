import Foundation
import  UIKit

extension UILabel {
    
    func setVisualMode() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
