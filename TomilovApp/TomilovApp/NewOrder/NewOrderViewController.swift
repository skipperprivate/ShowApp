import UIKit

final class NewOrderViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()
    
    private let contentScrollView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите ответ"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setUp()
    }
    
    // MARK: - Private methods
    
    private func setUp() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentScrollView.addSubview(nameTextfield)
    }

}
