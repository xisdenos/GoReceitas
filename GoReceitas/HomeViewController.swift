import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var homeBarButtonItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.welcomeLabel.text = "Olá, usuário"
        self.homeBarButtonItem.title = "Home"
        self.homeBarButtonItem.image = UIImage(named: "home")
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
