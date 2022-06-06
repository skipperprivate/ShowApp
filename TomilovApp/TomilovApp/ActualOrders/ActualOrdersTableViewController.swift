import UIKit

class ActualOrdersTableViewController: UITableViewController {
    
    // MARK: - Private types

    private typealias ActualOrders = String.ActualOrders
    
    // MARK: - Private properties
    
    private let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let emergencyUpdateButtonView: UIView = {
        let statView = UIView()
        statView.frame.origin = .zero
        statView.backgroundColor = UIColor.tertiarySystemBackground
        return statView
    }()
    
    private let emergencyUpdateButton: TomilovButton = {
        let openStatButton = TomilovButton(frame: .zero)
        openStatButton.setTitle(ActualOrders.EmergencyButton.title, for: .normal)
        openStatButton.addTarget(self, action: #selector(emergencyUpdateButtonClicked(sender:)), for: .touchUpInside)
        openStatButton.backgroundColor = UIColor.tomilovYellow
        return openStatButton
    }()
    
    private weak var timer: Timer?
    
    private let updateQueue = DispatchQueue(label: "updateQueue.tomilovApp.com", qos: .userInitiated)
    private let sectionCount = 1
    private let reuseIdentifier = "actualOrderCell"
    private var actualOrdersData: [[String]]?
    private var presenter: ActualOrdersPresenter?
    
    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ActualOrdersPresenter()
        
        setUp()
        actualOrdersData = presenter?.getActualOrders()
        NotificationCenter.default.addObserver(self, selector: #selector(appWillShow), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deliveryRequestMade), name: Notification.Name("deliveryRequestMade"), object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ordersCount = actualOrdersData?.count else {
            return 0
        }
        
        return ordersCount
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return emergencyUpdateButtonView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ActualOrderTableViewCell else {
            return UITableViewCell()
        }

        if let orders = actualOrdersData {
            cell.orderIdLabel.text = orders[indexPath.row][0]
            cell.clientInfo.text = orders[indexPath.row][1]
            cell.clientAddressLabel.text = orders[indexPath.row][2]
            cell.orderStatusLabel.text = orders[indexPath.row][3]
            if orders[indexPath.row][4] == "yndx" {
                cell.backgroundColor = .tomilovYandexColor
            }
            if orders[indexPath.row][4] == "dstvst" {
                cell.backgroundColor = .tomilovDostavistaColor
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ActualOrderTableViewCell
        let idText = cell?.orderIdLabel.text
        if let id = idText {
            let vc = ActualOrderInfoViewController(with: id)
            vc.hidesBottomBarWhenPushed = true
            vc.view.backgroundColor = UIColor.tertiarySystemBackground
        
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        title = ActualOrders.Title.title
        
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ActualOrderTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self
        rightBarButton.width = 30.0
        rightBarButton.image = UIImage(systemName: "plus")
        rightBarButton.action = #selector(newOrderCreateClicked(sender :))
        navigationItem.rightBarButtonItem  = rightBarButton
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.target = self
        leftBarButton.width = 30.0
        leftBarButton.image = UIImage(systemName: "play")
        leftBarButton.action = #selector(updateButtonClicked(sender :))
        navigationItem.leftBarButtonItem  = leftBarButton
        
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalTo: loadingIndicator.widthAnchor)
        ])
        
        emergencyUpdateButtonView.addSubview(emergencyUpdateButton)
        emergencyUpdateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emergencyUpdateButton.centerXAnchor.constraint(equalTo: emergencyUpdateButtonView.centerXAnchor).isActive = true
        emergencyUpdateButton.leftAnchor.constraint(equalTo: emergencyUpdateButtonView.leftAnchor, constant: 5).isActive = true
        emergencyUpdateButton.rightAnchor.constraint(lessThanOrEqualTo: emergencyUpdateButtonView.rightAnchor, constant:-5).isActive = true
        
        view.addSubview(emergencyUpdateButtonView)
    }
    
    @objc private func appWillShow() {
        updateInfo()
    }
    
    @objc private func deliveryRequestMade() {
        updateInfo()
    }
    
    @objc private func updateButtonClicked(sender: Any) {
        updateInfo()
    }
    
    @objc private func newOrderCreateClicked(sender: Any) {
        let vc = NewOrderViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.view.backgroundColor = UIColor.tertiarySystemBackground
    
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func emergencyUpdateButtonClicked(sender: Any) {
        loadingIndicator.isAnimating = true
        //updateQueue.async { [weak self] in
        actualOrdersData = presenter?.makeEmergencyUpdate()
            //DispatchQueue.main.async {
                tableView.reloadData()
                loadingIndicator.isAnimating = false
            //}
        //}
    }
    
    private func updateInfo() {
        updateQueue.async { [weak self] in
            self?.actualOrdersData = self?.presenter?.getActualOrders()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

}
