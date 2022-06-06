import UIKit

class ActualOrderInfoViewController: UIViewController {
    
    // MARK: - Private types

    private typealias ActualOrderInfo = String.ActualOrderInfo
    
    // MARK: - Private properties
    
    private let shareBarNuttonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.width = 30.0
        barButtonItem.image = UIImage(systemName: "square.and.arrow.up")
        barButtonItem.action = #selector(shareButtonClicked(_:))
        return barButtonItem
    }()
    
    private lazy var estimateCostsButton: TomilovButton = {
        let estimateCostButton = TomilovButton(frame: .zero)
        estimateCostButton.setTitle(ActualOrderInfo.Button.EstimateCostsButton.title, for: .normal)
        estimateCostButton.addTarget(self, action: #selector(openEstimateCostsClicked(sender:)), for: .touchUpInside)
        estimateCostButton.backgroundColor = UIColor.tomilovYellow
        return estimateCostButton
    }()
    
    private let openOrderServiceButton: TomilovButton = {
        let openServiceButton = TomilovButton(frame: .zero)
        openServiceButton.setTitle(ActualOrderInfo.Button.OpenOrderServiceButton.title, for: .normal)
        openServiceButton.addTarget(self, action: #selector(openOrderServiceClicked(sender:)), for: .touchUpInside)
        openServiceButton.backgroundColor = UIColor.tomilovYellow
        return openServiceButton
    }()
    
    private let orderInfoTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
        tableView.frame.origin = .zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let reuseIdentifier = "orderInfoCell"
    private var presenter: ActualOrderInfoPresenter?
    private var orderInfo:[String]?

    // MARK: - Init
    
    init(with id: String) {
        super.init(nibName: nil, bundle: nil)
        presenter = ActualOrderInfoPresenter()
        orderInfo = presenter?.getActualOrderInfo(id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ActualOrderInfoPresenter()
        setUp()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(with: size)
    }
    
    // MARK: - Private methods

    private func setUp() {
        addSwipeGestureRecognizer()
        
        navigationItem.title = ActualOrderInfo.Title.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        orderInfoTableView.dataSource = self
        orderInfoTableView.delegate = self
        orderInfoTableView.register(OrderInfoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(orderInfoTableView)
        updateLayout(with: view.frame.size)
        
        view.addSubview(openOrderServiceButton)
        shareBarNuttonItem.target = self
        navigationItem.rightBarButtonItem = shareBarNuttonItem
        
        if let orderStatus = orderInfo?[6], orderStatus != OrderStatus.ended {
            addEstimateCostsButtonButton()
        }
        
        openOrderServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        openOrderServiceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        openOrderServiceButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        openOrderServiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        openOrderServiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func updateLayout(with size: CGSize) {
       orderInfoTableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    private func addEstimateCostsButtonButton() {
        view.addSubview(estimateCostsButton)
        estimateCostsButton.leftAnchor.constraint(equalTo: openOrderServiceButton.leftAnchor).isActive = true
        estimateCostsButton.rightAnchor.constraint(equalTo: openOrderServiceButton.rightAnchor).isActive = true
        estimateCostsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        estimateCostsButton.bottomAnchor.constraint(equalTo: openOrderServiceButton.topAnchor, constant: -10).isActive = true
        estimateCostsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func shareButtonClicked(_ sender: Any) {
        guard let address = orderInfoTableView.cellForRow(at: IndexPath(row: 2, section: 0))?.textLabel?.text,
              let clientInfo = orderInfoTableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text,
              let addressInfo = orderInfoTableView.cellForRow(at: IndexPath(row: 3, section: 0))?.textLabel?.text else {
            return
        }
        
        var items: [Any] = []
        items.append(clientInfo + "\n" + address + "\n" + addressInfo)
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)

        present(activityController, animated: true, completion: nil)
    }
    
    @objc private func openEstimateCostsClicked(sender: Any) {
        guard let orderId = orderInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text else {
            return
        }
        
        let costsEstimateVC = CostsEstimateViewController(with: orderId)
        costsEstimateVC.hidesBottomBarWhenPushed = true
        costsEstimateVC.view.backgroundColor = UIColor.tertiarySystemBackground
        
        navigationController?.pushViewController(costsEstimateVC, animated: true)
    }
    
    @objc private func openOrderServiceClicked(sender: Any) {
        guard let orderID = orderInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text else {
            return
        }
        
        let redirect: (URL) -> Void = { serviceURL in
            UIApplication.shared.open(serviceURL)
        }
        
        presenter?.openOrderService(orderID, redirect)
    }
    
    @objc private func clientPhoneCallClicked() {
        let redirect: (URL) -> Void = { phoneURL in
            UIApplication.shared.open(phoneURL)
        }
        
        if let info = orderInfo,
           let clientInfo = info[1] as? String {
            presenter?.makePhoneCall(clientInfo, redirect)
        }
    }
    
    @objc private func deliveryServiceClicked() {
        let redirect: (URL) -> Void = { deliveryURL in
            UIApplication.shared.open(deliveryURL)
        }
        
        if let info = orderInfo,
           let deliveryServiceUrl = info[7] as? String {
            presenter?.goToDeliveryService(deliveryServiceUrl, redirect)
        }
    }
    
    private func addSwipeGestureRecognizer() {
        let tapGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapGestureHandler(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource extension

extension ActualOrderInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let infoAmount = orderInfo?.count else {
            return 0
        }
        
        return infoAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? OrderInfoTableViewCell else {
            return UITableViewCell()
        }
        
        if let info = orderInfo {
            cell.textLabel?.text = info[indexPath.row]
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate extension

extension ActualOrderInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            clientPhoneCallClicked()
        }
        if let count = orderInfo?.count, indexPath.row == count - 1 {
            deliveryServiceClicked()
        }
        orderInfoTableView.deselectRow(at: indexPath, animated: false)
    }
    
}
