import UIKit

final class HistoryOrderInfoViewController: UIViewController {
    
    // MARK: - Private types

    private typealias HistoryOrderInfo = String.HistoryOrderInfo
    
    // MARK: - Private properties
    
    private let orderInfoTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
        tableView.frame.origin = .zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let reuseIdentifier = "orderInfoCell"
    private var presenter: HistoryOrderInfoPresenter?
    private var orderInfo:[String]?

    // MARK: - Init
    
    init(with id: String) {
        super.init(nibName: nil, bundle: nil)
        presenter = HistoryOrderInfoPresenter()
        orderInfo = presenter?.getHistoryOrderInfo(id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(with: size)
    }
    
    // MARK: - Private methods

    private func setUp() {
        addSwipeGestureRecognizer()
        
        navigationItem.title = HistoryOrderInfo.Title.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        orderInfoTableView.dataSource = self
        orderInfoTableView.register(HistoryOrderTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(orderInfoTableView)
        updateLayout(with: view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
       orderInfoTableView.frame = CGRect.init(origin: .zero, size: size)
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

extension HistoryOrderInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let infoAmount = orderInfo?.count else {
            return 0
        }
        
        return infoAmount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HistoryOrderTableViewCell else {
            return UITableViewCell()
        }
        
        if let info = orderInfo {
            cell.textLabel?.text = info[indexPath.row]
        }
        
        return cell
    }
    
}
