
import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private enum Constants {
        static let loginLabelTopOffset = 120
        static let loginLabelHorizontalOffset = 70
        
        static let textFieldStackViewTopOffset = 32
        static let textFieldStackViewHorizontalOffset = 35
        
        static let buttonsHeight = 50
        static let buttonsStackViewTopOffset = 22
        static let buttonsStackViewHorizontalOffset = 55
        
        static let loginLabelFontSize = 36
    }
    
    private enum Text {
        static let loginLabel = "Music Search"
        static let emailTextField = "Enter email"
        static let passwordTextField = "Enter password"
        static let signUpButton = "Not a member? SignUp"
        static let signInButton = "SignIn"
    }
    
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = Text.loginLabel
        label.font = label.font.withSize(CGFloat(Constants.loginLabelFontSize))
        label.textColor = Color.labelColor.color
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.emailTextField
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.passwordTextField
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.signUpButton.color
        button.setTitle(Text.signUpButton, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.signInButton.color
        button.setTitle(Text.signInButton, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    @objc private func signInButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let user = findUserDataBase(email: email)
        
        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = Color.errorLabelColor.color
        } else if user?.password == password {
            let navVC = UINavigationController(rootViewController: AlbumsViewController())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
            
            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser)
        } else {
            loginLabel.text = "Wrong password"
            loginLabel.textColor = Color.errorLabelColor.color
        }
    }
    
    private func findUserDataBase(email: String) -> User? {
        let dataBase = DataBase.shared.users
        print(dataBase)
        
        for user in dataBase {
            if user.email == email {
                return user
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupViews()
        setConstraints()
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

private extension AuthViewController {
    
    func setupViews() {
        title = "SignIn"
        view.backgroundColor = .white
        
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        textFieldsStackView.axis = .vertical
        textFieldsStackView.spacing = 10
        textFieldsStackView.distribution = .fillProportionally
        
        buttonsStackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        buttonsStackView.distribution = .fillProportionally
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(textFieldsStackView)
        backgroundView.addSubview(buttonsStackView)
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(scrollView.snp.centerY)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.loginLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.loginLabelHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.loginLabelHorizontalOffset)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Constants.textFieldStackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.textFieldStackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.textFieldStackViewHorizontalOffset)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonsHeight)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonsHeight)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(Constants.buttonsStackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.buttonsStackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.buttonsStackViewHorizontalOffset)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
    
    
    
    
