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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configCaracteres()
        backLogin()
    }
    
    func configCaracteres(){
        
        voltarButton.setImage(UIImage(named: "back"), for: .normal)
        
        goLabel.text = "Go"
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        receitasLabel.text = "Receitas"
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logoTopImage.image = UIImage(named: "logoTop")
        
        cadastrarLabel.text = "Cadastrar"
        cadastrarLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        
        nameLabel.text = "Nome"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldName.placeholder = "Digite seu Nome:"
        
        emailLabel.text = "Email"
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldEmail.placeholder = "Digite seu Email:"
        
        senhaLabel.text = "Senha"
        senhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldSenha.placeholder = "Digite sua Senha:"
        
        confirmarSenhaLabel.text = "Confirmar a sua senha"
        confirmarSenhaLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        textFieldConfirmarSenha.placeholder = "Digite sua Senha Novamente:"
        
        cadastrarButton.setTitle("Cadastrar", for: .normal)
        cadastrarButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        cadastrarButton.setTitleColor(.white, for: .normal)
        cadastrarButton.layer.cornerRadius = 10
        cadastrarButton.clipsToBounds = true
        
        logoImage.image = UIImage(named: "logoFundo")
        
    }
    func backLogin(){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(ciColor: .black), .font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        let attributedTitle = NSMutableAttributedString(string: "Já tem conta? ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: "Login", attributes: boldAtts))
        backLoginButton.setAttributedTitle(attributedTitle, for: .normal)
        backLoginButton.setTitleColor(UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), for: .normal)    }
    
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        
    }
    
    
    
    @IBAction func tappedCadastrarButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func tappedJaTemLoginButton(_ sender: Any) {
        
    }
    
    
}


