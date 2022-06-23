
import UIKit

class UserInfoViewController: UIViewController {
    
    private enum Constants {
        static let stackViewTopOffset = 31
        static let stackViewHorizontalOffset = 40
        
        static let labelFontSize = 16
        static let labelTextFontSize = 18
    }
    
    private enum Text {
        static let viewTitle = "Profile"
        static let firstNameLabel = "First Name"
        static let secondNameLabel = "Second Name"
        static let ageLabel = "Birthday"
        static let phoneLabel = "Phone"
        static let emailLabel = "Email"
        static let passwordLabel = "Password"
    }
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = Text.firstNameLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.textColor = Color.labelColor.color
        return label
    }()
    
    private let firstNameLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelTextFontSize))
        return label
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = Text.secondNameLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.textColor = Color.labelColor.color
        return label
    }()
    
    private let secondNameLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelTextFontSize))
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = Text.ageLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.textColor = Color.labelColor.color
        return label
    }()
    
    private let ageLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelTextFontSize))
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = Text.phoneLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.textColor = Color.labelColor.color
        return label
    }()
    
    private let phoneLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelTextFontSize))
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Text.emailLabel
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.textColor = Color.labelColor.color
        return label
    }()
    
    private let emailLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelTextFontSize))
        return label
    }()
    
    
    private var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
    }
    
    private func setupViews() {
        title = Text.viewTitle
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                   firstNameLabelText,
                                                   secondNameLabel,
                                                   secondNameLabelText,
                                                   ageLabel,
                                                   ageLabelText,
                                                   phoneLabel,
                                                   phoneLabelText,
                                                   emailLabel,
                                                   emailLabelText])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
    }
    
    private func setModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)
        
        firstNameLabelText.text = activeUser.firstName
        secondNameLabelText.text = activeUser.secondName
        phoneLabelText.text = activeUser.phone
        emailLabelText.text = activeUser.email
        ageLabelText.text = dateString
    }
}

//MARK: - SetConstraints

extension UserInfoViewController {
    
    private func setConstraints() {
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.stackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.stackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.stackViewHorizontalOffset)
        }
    }
}



