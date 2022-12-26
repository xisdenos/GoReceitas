import UIKit

extension UIColor {
    static var viewBackgroundColor: UIColor {
        return UIColor(named: "viewBackground") ?? .red
    }
    
    static var textColorDefault: UIColor {
        return UIColor(named: "textColorDefault") ?? .red
    }
}
