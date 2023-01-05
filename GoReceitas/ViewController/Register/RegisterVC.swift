//
//  RegisterVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
import FirebaseFirestore

enum RegisterDescriptions: String {
    case goLabel = "Go"
    case topLabel = "Receitas"
    case registerLabel = "Register"
    case nameLabel = "Name"
    case nameTextField = "Your name..."
    case emailLabel = "E-mail"
    case emailTextField = "Your email..."
}

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
    
    private var auth: Auth?
    private var alert: AlertController?
    
    var firestore: Firestore?
    var user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
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
        
        let email: String = textFieldEmail.text ?? ""
        let senha: String = textFieldSenha.text ?? ""
        
        let confirmarSenha:String = textFieldConfirmarSenha.text ?? ""
        
        if senha == confirmarSenha {
            self.auth?.createUser(withEmail: email, password: senha, completion: { [weak self] result, error in
                if error != nil{
                    self?.alert?.alertInformation(title: "Heads up", message: "Error registering, check the data and try again")
                } else {
                    
                    let name = result?.user.email ?? "no email"
                    let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                    let userRef = self?.firestore?.collection("usuarios").document(emailFormatted)
                    
                    userRef?.getDocument { snapshot, error in
                        guard let snapshot else { return }
                        if !snapshot.exists {
                            userRef?.setData([
                                "nome": self?.textFieldName.text ?? "user",
                                "email": self?.textFieldEmail.text ?? "no email",
                            ]) { error in
                                if error != nil {
                                    print("Error writing document: (error.localizedDescription)")
                                } else {
                                    print("User data successfully written to Firestore!")
                                }
                            }
                        }
                    }

                    
                    self?.alert?.alertInformation(title: "Success", message: "Successfully registered user", completion: {
                        let homeVC: MainTabBarController? =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? MainTabBarController
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            // igor-gmail-com
                            let database = Database.database().reference()
                            let data = ["name": name, "email": email]
                            let emailFormatted = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
                            database.child("users").child(emailFormatted).setValue(data)
                        }
                        
                        self?.navigationController?.pushViewController(homeVC ?? UIViewController(), animated: true)
                    })
                }
            })
        } else {
            self.alert?.alertInformation(title: "Heads up", message: "Divergent Passwords")
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
