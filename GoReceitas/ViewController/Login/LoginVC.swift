//
//  LoginVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var receitasLabel: UILabel!
    @IBOutlet weak var imageTopLogo: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var senhaLabel: UILabel!
    @IBOutlet weak var textFieldSenha: UITextField!
    @IBOutlet weak var esqueceuSenhaButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var ouLabel: UILabel!
    @IBOutlet weak var loginGoogleButton: UIButton!
    @IBOutlet weak var fazerCadastroButton: UIButton!
    @IBOutlet weak var riscoView1: UIView!
    @IBOutlet weak var riscoView2: UIView!
    @IBOutlet weak var riscoView3: UIView!
    @IBOutlet weak var imageLogoFundo: UIImageView!
    
    var auth:Auth?
    var alert: AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        configCaracteristicas()
        JaTemCadastro()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
    func configCaracteristicas(){
        
        goLabel.text = LoginRegisterDescriptions.goLabel.rawValue
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        receitasLabel.text = LoginRegisterDescriptions.topLabel.rawValue
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        
        imageTopLogo.image = UIImage(named: "topLogo")
        
        emailLabel.text = LoginRegisterDescriptions.emailLabel.rawValue
        emailLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        textFieldEmail.placeholder = LoginRegisterDescriptions.emailTextField.rawValue
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.delegate = self
        
        senhaLabel.text = LoginRegisterDescriptions.passwordLabel.rawValue
        senhaLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        textFieldSenha.placeholder = LoginRegisterDescriptions.passwordTextField.rawValue
        textFieldSenha.isSecureTextEntry = true
        textFieldSenha.delegate = self
        
        
        loginButton.setTitle(LoginRegisterDescriptions.signInLabel.rawValue, for: .normal)
        loginButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        loginButton.setTitleColor(.white.withAlphaComponent(0.4), for: .disabled)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        loginButton.isEnabled = false
        
        
        ouLabel.text = LoginRegisterDescriptions.orLabel.rawValue
        
        riscoView1.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        riscoView2.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        riscoView3.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        loginGoogleButton.setTitle(LoginRegisterDescriptions.signInWithGoogel.rawValue, for: .normal)
        loginGoogleButton.setTitleColor(.black, for: .normal)
        loginGoogleButton.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 221/255, alpha: 1)
        loginGoogleButton.layer.cornerRadius = 10
        loginGoogleButton.clipsToBounds = true
        
        imageLogoFundo.image = UIImage(named: "logoFundo")
    }
    
    func JaTemCadastro(){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(ciColor: .black), .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        let attributedTitle = NSMutableAttributedString(string: LoginRegisterDescriptions.noAccountLabel.rawValue, attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: LoginRegisterDescriptions.signUpLabel.rawValue, attributes: boldAtts))
        fazerCadastroButton.setAttributedTitle(attributedTitle, for: .normal)
        fazerCadastroButton.setTitleColor(UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), for: .normal)    }
    
    
    
    
    func validacaoTextField(){
        if textFieldEmail.text != "" && textFieldSenha.text != ""{
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func tappedEsqueceuSenha(_ sender: UIButton) {
        let vc = UIStoryboard(name: "EsqueceuSenhaVC", bundle: nil).instantiateViewController(withIdentifier: "EsqueceuSenhaVC") as? EsqueceuSenhaVC
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    @IBAction func tappedLogin(_ sender: UIButton) {
        
        let email: String = self.textFieldEmail.text ?? ""
        let password: String = self.textFieldSenha.text ?? ""
        
        self.auth?.signIn(withEmail: email, password: password, completion: { [weak self] usuario, error in
            if error != nil {
                self?.alert?.alertInformation(title: "Atenção", message: "Dados incorretos, tente novamente")
                
            } else {
                if usuario == nil{
                    self?.alert?.alertInformation(title: "Atenção", message: "Tivemos um problema inesperado")
                } else {
                    let homeVC: MainTabBarController? =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? MainTabBarController
                    self?.navigationController?.pushViewController(homeVC ?? UIViewController(), animated: true)
                }
            }
        })
    }
    
    
    
    @IBAction func tappedLoginGoogle(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            guard error == nil else {
                self.alert?.alertInformation(title: "Atenção", message: "Falha ao tentar realizar o login, Tente Novamente!")
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { [weak self] dataResult, error in
                guard error == nil else {
                    self?.alert?.alertInformation(title: "Atenção", message: "Falha ao tentar realizar o login, Tente Novamente!")
                    return
                }
                
                let homeVC: MainTabBarController? =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? MainTabBarController
                self?.navigationController?.pushViewController(homeVC ?? UIViewController(), animated: true)
            }
        }
    }
    
    
    @IBAction func tappedFazerCadastroButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RegisterVC", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension LoginVC: UITextFieldDelegate {
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


