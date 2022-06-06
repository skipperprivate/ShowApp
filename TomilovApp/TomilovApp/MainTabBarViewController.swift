import UIKit

final class MainTabBarViewController: UITabBarController {

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }
    
    // MARK: - Private methods
    
    private func setupControllers() {
        let actualOrdersVC = ActualOrdersTableViewController()
        let actualOrdersNAVC = UINavigationController(rootViewController: actualOrdersVC)
        actualOrdersNAVC.modalPresentationStyle = .fullScreen
        let firstVC = actualOrdersNAVC
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let historyVC = HistoryTableViewController()
        let historyNAVC = UINavigationController(rootViewController: historyVC)
        historyNAVC.modalPresentationStyle = .fullScreen
        let secondVC = historyNAVC
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let settingsVC = SettingsViewController()
        let settingsNAVC = UINavigationController(rootViewController: settingsVC)
        settingsNAVC.modalPresentationStyle = .fullScreen
        let thirdVC = settingsNAVC
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        viewControllers = [firstVC, secondVC, thirdVC]
    }

}
