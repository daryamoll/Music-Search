
import UIKit

enum Color {
    case signUpButton
    case signInButton
    case labelColor
    case errorLabelColor
    
    var color: UIColor? {
        switch self {
            case .signUpButton:
                return UIColor(displayP3Red: 85/255, green: 132/255, blue: 172/255, alpha: 1)
                
            case .signInButton:
                return UIColor(displayP3Red: 149/255, green: 209/255, blue: 204/255, alpha: 1)
                
            case .labelColor:
                return UIColor(displayP3Red: 34/255, green: 87/255, blue: 126/255, alpha: 1)
                
            case .errorLabelColor:
                return UIColor(displayP3Red: 244/255, green: 124/255, blue: 124/255, alpha: 1)
        }
    }
}
