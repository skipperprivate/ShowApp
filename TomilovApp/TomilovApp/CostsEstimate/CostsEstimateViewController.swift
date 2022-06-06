import UIKit

class CostsEstimateViewController: UIViewController {

    // MARK: - Private types

    private typealias CostEstimate = String.CostEstimate
    
    // MARK: - Private properties
    
    private let estimateCostsTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        tableView.frame.origin = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let reuseIdentifier = "estimateCostCell"
    private let sectionCount = 2
    private let rowsInSectionCount = 4
    
    private var presenter: CostsEstimatePresenter
    private var deliveryCosts: [String]?
    private var orderId: String?
    
    private var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    // MARK: - Init
    
    init(with id: String) {
        presenter = CostsEstimatePresenter()
        super.init(nibName: nil, bundle: nil)
        orderId = id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()*/

        setUp()
        loadingIndicator.isAnimating = true
        if let orderId = orderId {
            presenter.getDeliveryEstimationCosts(with: orderId){ [weak self] (output) in
                DispatchQueue.main.async {
                    self?.deliveryCosts = output
                    self?.estimateCostsTableView.reloadData()
                    self?.loadingIndicator.isAnimating = false
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(with: size)
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        navigationItem.title = CostEstimate.Title.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        estimateCostsTableView.delegate = self
        estimateCostsTableView.dataSource  = self
        estimateCostsTableView.register(CostEstimateTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(estimateCostsTableView)
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalTo: loadingIndicator.widthAnchor)
        ])
        updateLayout(with: view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
        estimateCostsTableView.frame = CGRect.init(origin: .zero, size: size)
    }

}

// MARK: - UITableViewDelegate extension

extension CostsEstimateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var deliveryService = ""
        var restaurantAddress = ""
        var transportType = ""
        if indexPath.section == 0 {
            deliveryService = CostEstimate.DeliveryService.dostavista
        }
        else {
            deliveryService = CostEstimate.DeliveryService.yandex
        }
        
        if indexPath.row < 2 {
            restaurantAddress = CostEstimate.RestaurantAddressFullName.kuntsevo
        }
        else {
            restaurantAddress = CostEstimate.RestaurantAddressFullName.mozaika
        }
        
        if indexPath.row % 2 == 0 {
            transportType = CostEstimate.TransportType.car
        }
        else {
            transportType = CostEstimate.TransportType.man
        }

        if let orderId = orderId {
            let deliveryServiceVC = DeliveryRequestViewController(id: orderId,
                                                                  service: deliveryService,
                                                                  type: transportType,
                                                                  address: restaurantAddress)
            
            navigationController?.pushViewController(deliveryServiceVC, animated: true)
            estimateCostsTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}

// MARK: - UITableViewDataSource extension

extension CostsEstimateViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CostEstimateTableViewCell else {
            return UITableViewCell()
        }
        
        var indexStep = 0
        
        if indexPath.section == 1 {
            indexStep = 4
        }
        
        guard let costsArray = deliveryCosts, costsArray.count > indexPath.row + indexStep else {
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 0 {
            cell.deliveryLogoImageView.image = UIImage(named: "car")
        }
        else {
            cell.deliveryLogoImageView.image = UIImage(named: "courier")
        }
        
        if indexPath.row < 2 {
            cell.restaurantAddressLabel.tintColor = .blue
            cell.restaurantAddressLabel.text = CostEstimate.RestaurantAddress.kuntsevo
        }
        else {
            cell.restaurantAddressLabel.tintColor = .green
            cell.restaurantAddressLabel.text = CostEstimate.RestaurantAddress.mozaika
        }
        
        cell.costDeliveryLabel.text = costsArray[indexPath.row + indexStep]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return CostEstimate.DeliveryService.dostavista
        }
        else {
            return CostEstimate.DeliveryService.yandex
        }
    }
    
}
