import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Private types

    private typealias Settings = String.Settings
    
    // MARK: - Private properties
    
    private let phoneTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.insetGrouped)
        tableView.frame.origin = .zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let reuseIdentifier = "phoneTableCell"
    private let presenter: SettingsPresenter
    
    private let phoneInfo = [[Settings.Phone.PhoneNumberOwners.yandexFood, Settings.Phone.PhoneNumbers.yandexFood],
                             [Settings.Phone.PhoneNumberOwners.yandexClient1, Settings.Phone.PhoneNumbers.yandexClient1],
                             [Settings.Phone.PhoneNumberOwners.yandexClient2, Settings.Phone.PhoneNumbers.yandexClient2]]

    // MARK: - Init
    
    init() {
        presenter = SettingsPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        title = String.Settings.Title.title
        
        phoneTableView.delegate = self
        phoneTableView.dataSource  = self
        phoneTableView.register(PhoneTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(phoneTableView)
        updateLayout(with: view.frame.size)
    }
    
    private func updateLayout(with size: CGSize) {
        phoneTableView.frame = CGRect.init(origin: .zero, size: size)
    }

}

// MARK: - UITableViewDelegate extension

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let redirect: (URL) -> Void = { phoneURL in
            UIApplication.shared.open(phoneURL)
        }
        
        presenter.makePhoneCall(phoneInfo[indexPath.row][1], redirect)
        
        phoneTableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource extension

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PhoneTableViewCell else {
            return UITableViewCell()
        }
        
        cell.phoneOwnerNameLabel.text = phoneInfo[indexPath.row][0]
        cell.phoneNumberLabel.text = phoneInfo[indexPath.row][1]
        
        return cell
    }
    
}
