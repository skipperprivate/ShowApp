import UIKit

class CostEstimateTableViewCell: UITableViewCell {
    
    // MARK: - Public properties

    public let deliveryLogoImageView: UIImageView = {
        let img = UIImageView()
        img.frame.size = CGSize(width: 75, height: 75)
        img.translatesAutoresizingMaskIntoConstraints = true
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.backgroundColor = UIColor.clear
        return img
    }()
    
    public let costDeliveryLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        lbl.textAlignment = .center
        lbl.tintColor = UIColor.white
        lbl.setVisualMode()
        return lbl
    }()
    
    public let restaurantAddressLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.boldSystemFont(ofSize: 30.0)
        lbl.textAlignment = .center
        lbl.setVisualMode()
        return lbl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        contentView.addSubview(deliveryLogoImageView)
        contentView.addSubview(costDeliveryLabel)
        contentView.addSubview(restaurantAddressLabel)
        
        costDeliveryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        costDeliveryLabel.leftAnchor.constraint(equalTo: deliveryLogoImageView.rightAnchor, constant: 5).isActive = true
        costDeliveryLabel.rightAnchor.constraint(lessThanOrEqualTo: restaurantAddressLabel.leftAnchor, constant: -5).isActive = true
        
        restaurantAddressLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        restaurantAddressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:-10).isActive = true
        
        deliveryLogoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        deliveryLogoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    }

}
