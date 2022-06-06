import Foundation
import UIKit

public class TomilovButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.lineBreakMode = .byWordWrapping

        setTitleColor(.black, for: .normal)
        contentVerticalAlignment = .center
        layer.cornerRadius = 10.0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
