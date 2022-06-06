import UIKit

class DeliveryRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private let infoTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        tableView.frame.origin = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let openOrderServiceButton: TomilovButton = {
        let openServiceButton = TomilovButton(frame: CGRect(x: 0, y: 0, width: 100, height: 150))
        openServiceButton.setTitle("Заказать", for: .normal)
        openServiceButton.addTarget(self, action: #selector(openOrderServiceClicked(sender:)), for: .touchUpInside)
        return openServiceButton
    }()

    private let reuseIdentifier = "infoCell"
    private let sectionCount = 1
    private let rowsInSectionCount = 4
    private let titleForTableHeader = "Информация"
    
    private var info: [String]?
    private var presenter: DeliveryRequestPresenter?
    
    // MARK: - Init
    
    init(id: String, service: String, type: String, address: String) {
        super.init(nibName: nil, bundle: nil)
        info = [id, service, type, address]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = DeliveryRequestPresenter()
        
        setUp()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        
        if let infoArray = info, infoArray.count > indexPath.row {
            cell.textLabel?.text = infoArray[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForTableHeader
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        view.backgroundColor = UIColor.tertiarySystemBackground
        
        openOrderServiceButton.backgroundColor = UIColor(red: 255/255, green: 202/255, blue: 0.0, alpha: 1)
        view.addSubview(openOrderServiceButton)
        
        openOrderServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        openOrderServiceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        openOrderServiceButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        openOrderServiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        openOrderServiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        infoTableView.delegate = self
        infoTableView.dataSource  = self
        infoTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(infoTableView)
        updateLayout(with: view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
        infoTableView.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2)
    }
    
    @objc private func openOrderServiceClicked(sender: Any) {
        guard let info = info, let isOrderCreated = presenter?.makeDeliveryRequest(info: info) else {
            throwAlertController()
            return
        }
        
        if isOrderCreated {
            NotificationCenter.default.post(name: Notification.Name("deliveryRequestMade"), object: nil)
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            throwAlertController()
        }
    }
    
    private func throwAlertController() {
        let alert = UIAlertController(title: "Ошибка", message: "Не создана заявка", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
