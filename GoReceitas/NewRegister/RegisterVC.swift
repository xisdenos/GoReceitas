//
//  RegisterVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit
import Firebase

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
    
    
    var auth:Auth?
    var alert: AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        configCaracteres()
        backLogin()
    }
    
    func configCaracteres(){
        
        voltarButton.setImage(UIImage(named: "back11"), for: .normal)
        
        goLabel.text = "Go"
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        receitasLabel.text = "Receitas"
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logoTopImage.image = UIImage(named: "logoTop")
        
        cadastrarLabel.text = "Cadastrar"
        cadastrarLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        
        nameLabel.text = "Nome"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldName.placeholder = "Digite seu Nome:"
        textFieldName.delegate = self
        
        emailLabel.text = "Email"
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldEmail.placeholder = "Digite seu Email:"
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.delegate = self
        
        senhaLabel.text = "Senha"
        senhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldSenha.placeholder = "Digite sua Senha:"
        textFieldSenha.isSecureTextEntry = true
        textFieldSenha.delegate = self
        
        confirmarSenhaLabel.text = "Confirmar a sua senha"
        confirmarSenhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldConfirmarSenha.placeholder = "Digite sua Senha Novamente:"
        textFieldConfirmarSenha.isSecureTextEntry = true
        textFieldConfirmarSenha.delegate = self
        
        cadastrarButton.setTitle("Cadastrar", for: .normal)
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
        let attributedTitle = NSMutableAttributedString(string: "Já tem conta? ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: "Login", attributes: boldAtts))
        backLoginButton.setAttributedTitle(attributedTitle, for: .normal)
        backLoginButton.setTitleColor(UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), for: .normal)    }
    
    
    
    func validacaoTextField(){
        let nome:String = self.textFieldName.text ?? ""
        let email:String = self.textFieldEmail.text ?? ""
        let senha:String = self.textFieldSenha.text ?? ""
        let confirmarSenha = self.textFieldConfirmarSenha.text ?? ""
        
        if !nome.isEmpty && !email.isEmpty && !senha.isEmpty && !confirmarSenha.isEmpty {
            self.configbuttonEnable(true)
        }else{
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
        
        let email:String = textFieldEmail.text ?? ""
        let senha:String = textFieldSenha.text ?? ""
        let confirmarSenha:String = textFieldConfirmarSenha.text ?? ""
        
        if senha == confirmarSenha {
            self.auth?.createUser(withEmail: email, password: senha, completion: { [self] result, error in
                
                if error != nil{
                    self.alert?.alertInformation(title: "Atenção", message: "Erro ao cadastrar, verifique os dados e tente novamente")
                }else{
                    self.alert?.alertInformation(title: "Parabens", message: "Usuario cadastrado com sucesso",completion: {
                        self.navigationController?.popViewController(animated: true)
                    })

                }
                
                
            })
            
        }else{
            self.alert?.alertInformation(title: "Atenção", message: "Senhas Divergentes")        }
        
        
        
        
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
