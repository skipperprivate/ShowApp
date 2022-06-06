import UIKit

class ActualOrderTableViewCell: UITableViewCell {

    // MARK: - Public properties
    
    public let orderIdLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.tintColor = UIColor.white
        lbl.setVisualMode()
        return lbl
    }()
    
    public let clientInfo: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        lbl.textAlignment = .left
        lbl.tintColor = UIColor.white
        lbl.setVisualMode()
        return lbl
    }()
    
    public let clientAddressLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        lbl.textAlignment = .left
        lbl.tintColor = UIColor.white
        lbl.setVisualMode()
        return lbl
    }()
    
    public let orderStatusLabel: UILabel = {
        let lbl = UILabel()
        lbl.frame.size = CGSize(width: 100, height: 30)
        lbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        lbl.textAlignment = .center
        lbl.tintColor = UIColor.white
        lbl.setVisualMode()
        return lbl
    }()
    
    // MARK: - Private properties
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame.size = CGSize(width: 100, height: 120)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12.0
        return stackView
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
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        
        cellStackView.addArrangedSubview(orderIdLabel)
        cellStackView.addArrangedSubview(clientInfo)
        cellStackView.addArrangedSubview(clientAddressLabel)
        
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(cellStackView)
        
        orderStatusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        orderStatusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        orderStatusLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        cellStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 15).isActive = true
        cellStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -15).isActive = true
        cellStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        cellStackView.rightAnchor.constraint(lessThanOrEqualTo: orderStatusLabel.leftAnchor, constant:-5).isActive = true
    }

}
