//
//  RegisterVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var voltarButton: UIButton!
    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var receitasLabel: UILabel!
    @IBOutlet weak var logoTopImage: UIImageView!
    @IBOutlet weak var cadastrarLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var senhaLabel: UILabel!
    @IBOutlet weak var textFieldSenha: UITextField!
    @IBOutlet weak var confirmarSenhaLabel: UILabel!
    @IBOutlet weak var textFieldConfirmarSenha: UITextField!
    @IBOutlet weak var cadastrarButton: UIButton!
    @IBOutlet weak var backLoginButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    
    private var alert: AlertController?
    private var viewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.set(delegate: self)
        alert = AlertController(controller: self)
        configCaracteres()
        backLogin()
        view.backgroundColor = .viewBackgroundColor
        setBackground()
    }
    
    func setBackground() {
        guard let background = Utils.getUserDefaults(key: "darkmode") as? Bool else { return }
        
        if background {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    func configCaracteres(){
        
        voltarButton.setImage(UIImage(named: "back11"), for: .normal)
        
        goLabel.text = LoginRegisterDescriptions.goLabel.rawValue
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        receitasLabel.text = LoginRegisterDescriptions.topLabel.rawValue
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logoTopImage.image = UIImage(named: "logoTop")
        
        cadastrarLabel.text = LoginRegisterDescriptions.registerLabel.rawValue
        cadastrarLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        
        nameLabel.text = RegisterDescriptions.nameLabel.rawValue
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldName.placeholder = LoginRegisterDescriptions.nameLabel.rawValue
        textFieldName.delegate = self
        
        emailLabel.text = LoginRegisterDescriptions.emailLabel.rawValue
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldEmail.placeholder = LoginRegisterDescriptions.emailTextField.rawValue
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.delegate = self
        
        senhaLabel.text = LoginRegisterDescriptions.passwordLabel.rawValue
        senhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldSenha.placeholder = LoginRegisterDescriptions.passwordTextField.rawValue
        textFieldSenha.isSecureTextEntry = true
        textFieldSenha.delegate = self
        
        confirmarSenhaLabel.text = LoginRegisterDescriptions.confirmPasswordLabel.rawValue
        confirmarSenhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldConfirmarSenha.placeholder = LoginRegisterDescriptions.confirmPasswordTextField.rawValue
        textFieldConfirmarSenha.isSecureTextEntry = true
        textFieldConfirmarSenha.delegate = self
        
        cadastrarButton.setTitle(LoginRegisterDescriptions.registerLabel.rawValue, for: .normal)
        cadastrarButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        cadastrarButton.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled)
        cadastrarButton.setTitleColor(.white, for: .normal)
        cadastrarButton.layer.cornerRadius = 10
        cadastrarButton.clipsToBounds = true
        cadastrarButton.isEnabled = false
        
        
        logoImage.image = UIImage(named: "logoFundo")
        
    }
    func backLogin(){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(ciColor: .black), .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        let attributedTitle = NSMutableAttributedString(string: LoginRegisterDescriptions.alreadyHaveAccount.rawValue, attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: LoginRegisterDescriptions.signInLabel.rawValue, attributes: boldAtts))
        backLoginButton.setAttributedTitle(attributedTitle, for: .normal)
        backLoginButton.setTitleColor(UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), for: .normal)    }
    
    
    
    func validacaoTextField(){
        let nome:String = self.textFieldName.text ?? ""
        let email:String = self.textFieldEmail.text ?? ""
        let senha:String = self.textFieldSenha.text ?? ""
        let confirmarSenha = self.textFieldConfirmarSenha.text ?? ""
        
        if !nome.isEmpty && !email.isEmpty && !senha.isEmpty && !confirmarSenha.isEmpty {
            self.configbuttonEnable(true)
        } else {
            self.configbuttonEnable(false)
        }
    }
    
    private func configbuttonEnable(_ enable:Bool){
        if enable{
            self.cadastrarButton.setTitleColor(.white, for: .normal)
            self.cadastrarButton.isEnabled = true
        }else{
            self.cadastrarButton.setTitleColor(.lightGray, for: .normal)
            self.cadastrarButton.isEnabled = false
        }
    }
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedCadastrarButton(_ sender: UIButton) {
        
        if let email = textFieldEmail.text,
           let password = textFieldSenha.text,
           let name = textFieldName.text,
           let passwordConfirmation = textFieldConfirmarSenha.text {
            viewModel.createUserWith(name, email, password, passwordConfirmation)
        }
    }
    
    
    @IBAction func tappedJaTemLoginButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension RegisterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validacaoTextField()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterVC: RegisterViewModelDelegate {
    func signUp() {
        let homeVC: MainTabBarController? =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? MainTabBarController
        navigationController?.pushViewController(homeVC ?? UIViewController(), animated: true)
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)?) {
        alert?.alertInformation(title: title, message: message, completion: {
            completion?()
        })
    }
}
