import UIKit

class HistoryTableViewController: UIViewController {
    
    // MARK: - Private types

    private typealias History = String.History
    
    // MARK: - Private properties
    
    private let historyTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.plain)
        tableView.frame.origin = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let statisticsView: UIView = {
        let statView = UIView()
        statView.frame.origin = .zero
        statView.backgroundColor = UIColor.tertiarySystemBackground
        return statView
    }()
    
    private let statisticsPeriodPickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let openStatiscticsButton: TomilovButton = {
        let openStatButton = TomilovButton(frame: .zero)
        openStatButton.setTitle(History.Button.title, for: .normal)
        openStatButton.addTarget(self, action: #selector(openStatisticsClicked(sender:)), for: .touchUpInside)
        openStatButton.backgroundColor = UIColor.tomilovYellow
        return openStatButton
    }()
    
    private let statisticsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12.0
        return stackView
    }()
    
    private let sectionCount = 1
    private let reuseIdentifier = "historyCell"
    
    private let componentsCount = 1
    private let numberOfRowsInComponent = 3
    private let pickerRowValues = [History.Picker.yesterday, History.Picker.week, History.Picker.month]
    
    private var historyData:[[String]]?
    private var presenter: HistoryPresenter?
    
    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HistoryPresenter()
        
        setUp()
        historyData = presenter?.getHistory(period: pickerRowValues[0])
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        title = History.Title.title
        
        historyTableView.delegate = self
        historyTableView.dataSource  = self
        historyTableView.register(ActualOrderTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        statisticsPeriodPickerView.delegate = self
        statisticsPeriodPickerView.dataSource = self
        
        statisticsStackView.addArrangedSubview(openStatiscticsButton)
        openStatiscticsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        statisticsStackView.addArrangedSubview(statisticsPeriodPickerView)
        statisticsPeriodPickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        statisticsView.addSubview(statisticsStackView)
        
        statisticsStackView.topAnchor.constraint(greaterThanOrEqualTo: statisticsView.topAnchor, constant: 15).isActive = true
        statisticsStackView.bottomAnchor.constraint(greaterThanOrEqualTo: statisticsView.bottomAnchor, constant: -15).isActive = true
        statisticsStackView.centerXAnchor.constraint(equalTo: statisticsView.centerXAnchor).isActive = true
        statisticsStackView.leftAnchor.constraint(equalTo: statisticsView.leftAnchor, constant: 5).isActive = true
        statisticsStackView.rightAnchor.constraint(lessThanOrEqualTo: statisticsView.rightAnchor, constant:-5).isActive = true
        
        view.addSubview(statisticsView)
        view.addSubview(historyTableView)
        
        updateLayout(with: view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
        historyTableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    @objc private func openStatisticsClicked(sender: Any) {
        let statisticVC = StatisticsViewController()
        statisticVC.hidesBottomBarWhenPushed = true
        statisticVC.view.backgroundColor = UIColor.tertiarySystemBackground
        
        navigationController?.pushViewController(statisticVC, animated: true)
    }

}

// MARK: - UITableViewDelegate extension

extension HistoryTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return statisticsView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = historyData {
            let id = data[indexPath.row][0]
            let vc = HistoryOrderInfoViewController(with: id)
            vc.hidesBottomBarWhenPushed = true
            vc.view.backgroundColor = UIColor.tertiarySystemBackground
        
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource extension

extension HistoryTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ordersCount = historyData?.count else {
            return 0
        }
        
        return ordersCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ActualOrderTableViewCell else {
            return UITableViewCell()
        }
        
        if let orders = historyData {
            cell.orderIdLabel.text = orders[indexPath.row][0]
            cell.clientInfo.text = orders[indexPath.row][1]
            cell.clientAddressLabel.text = orders[indexPath.row][2]
            cell.orderStatusLabel.text = orders[indexPath.row][5]
        }

        return cell
    }
    
}

// MARK: - UIPickerViewDelegate extension

extension HistoryTableViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRowsInComponent
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerRowValues[row]
    }
    
}

// MARK: - UIPickerViewDataSource extension

extension HistoryTableViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
