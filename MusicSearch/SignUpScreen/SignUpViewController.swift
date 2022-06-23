
import UIKit

class SignUpViewController: UIViewController {
    
    private enum Constants {
        static let scrollViewHeight = 620
        static let scrollViewWidth = 400
        
        static let loginLabelTopOffset = 30
        static let loginLabelLeadingOffset = 74
        static let loginLabelTrailingOffset = 72
        
        static let elementsStackViewTopOffset = 33
        static let elementsStackViewLeadingOffset = 23
        static let elementsStackViewTrailingOffset = 27
        
        static let signUpButtonHeight = 40
        static let signUpButtonWidth = 400
        static let signUpButtonTopOffset = 31
        static let signUpButtonLeadingOffset = 73
        static let signUpButtonTrailingOffset = 77
        
        static let loginLabelFontSize = 24
        static let labelsFontSize = 14
        
        static let buttonButtomOffset = 10
    }
    
    private enum Text {
        static let validLabel = "Required field"
        
        static let loginLabel = "Create new account"
        static let firstNameTextField = "First Name"
        static let secondNameTextField = "Second Name"
        static let phoneNumberTextField = "Phone"
        static let emailTextField = "E-mail"
        static let passwordTextField = "Password"
        static let signUpButton = "SignUP"
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: Constants.scrollViewWidth, height: 700)
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
        label.textColor = Color.labelColor.color
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.loginLabelFontSize))
        
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.firstNameTextField
        return textField
    }()
    
    private let firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
    }()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.secondNameTextField
        return textField
    }()
    
    private let secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
    }()
    
    private let ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.phoneNumberTextField
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Text.emailTextField
        return textField
    }()
    
    private let emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = Text.passwordTextField
        return textField
    }()
    
    private let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = Text.validLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelsFontSize))
        return label
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
    
    private var elementsStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    private let nameValidType: String.ValidTypes = .name
    private let emailValidType: String.ValidTypes = .email
    private let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setupDelegate()
        setupDataPicker()
    }
    
    private func setupViews() {
        title = "SignUp"
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        elementsStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                           firstNameValidLabel,
                                                           secondNameTextField,
                                                           secondNameValidLabel,
                                                           datePicker,
                                                           ageValidLabel,
                                                           phoneNumberTextField,
                                                           phoneValidLabel,
                                                           emailTextField,
                                                           emailValidLabel,
                                                           passwordTextField,
                                                           passwordValidLabel])
        
        elementsStackView.axis = .vertical
        elementsStackView.spacing = 10
        elementsStackView.distribution = .fillProportionally
        
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(signUpButton)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = #colorLiteral(red: 0.8810099265, green: 0.8810099265, blue: 0.8810099265, alpha: 1)
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    @objc private func signUpButtonTapped() {
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType) && secondNameText.isValid(validType: nameValidType) &&
            emailText.isValid(validType: emailValidType) &&
            passwordText.isValid(validType: passwordValidType) &&
            phoneText.count == 18 &&
            ageIsValid() == true {
            DataBase.shared.saveUser(firstName: firstNameText,
                                     secondName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: datePicker.date)
            loginLabel.text = "New account created"
            loginLabel.textColor = .green
        } else {
            loginLabel.text = "Create new account"
            alertOk(title: "Error", message: "Please fill in all the filds and make sure you are over 18 y.o.")
        }
    }
    
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneValidLabel.text = "Phone is valid"
            phoneValidLabel.textColor = .green
        } else {
            phoneValidLabel.text = "Phone is not valid"
            phoneValidLabel.textColor = .red
        }
        return result
    }
    
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday , to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
            case firstNameTextField:
                setTextField(textField: firstNameTextField,
                             label: firstNameValidLabel,
                             validType: nameValidType,
                             validMessage: "First name is valid",
                             wrongMessage: "Only A-Z characters",
                             string: string,
                             range: range)
                
            case secondNameTextField:
                setTextField(textField: secondNameTextField,
                             label: secondNameValidLabel,
                             validType: nameValidType,
                             validMessage: "Second name is valid",
                             wrongMessage: "Only A-Z characters",
                             string: string,
                             range: range)
                
            case emailTextField:
                setTextField(textField: emailTextField,
                             label: emailValidLabel,
                             validType: emailValidType,
                             validMessage: "Email is valid",
                             wrongMessage: "Email is not valid",
                             string: string,
                             range: range)
                
            case passwordTextField:
                setTextField(textField: passwordTextField,
                             label: passwordValidLabel,
                             validType: passwordValidType,
                             validMessage: "Password is valid",
                             wrongMessage: "Password is not valid",
                             string: string,
                             range: range)
            case phoneNumberTextField:
                phoneNumberTextField.text = setPhoneNumberMask(textField: phoneNumberTextField,
                                                               mask: "+X (XXX) XXX-XX-XX",
                                                               string: string,
                                                               range: range)
                
                
            default:
                break
        }
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - SetConstraints

private extension SignUpViewController {
    
    func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.greaterThanOrEqualToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.loginLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.loginLabelLeadingOffset)
            make.trailing.equalToSuperview().offset(-Constants.loginLabelTrailingOffset)
        }
        
        elementsStackView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Constants.elementsStackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.elementsStackViewLeadingOffset)
            make.trailing.equalToSuperview().offset(-Constants.elementsStackViewTrailingOffset)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(elementsStackView.snp.bottom).offset(Constants.signUpButtonTopOffset)
            make.leading.equalToSuperview().offset(Constants.signUpButtonLeadingOffset)
            make.trailing.equalToSuperview().offset(-Constants.signUpButtonTrailingOffset)
            make.height.equalTo(Constants.signUpButtonHeight)
            make.width.equalTo(Constants.signUpButtonWidth)
            make.bottom.lessThanOrEqualToSuperview().offset(-Constants.buttonButtomOffset)
        }
    }
}
