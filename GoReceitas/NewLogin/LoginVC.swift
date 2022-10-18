//
//  LoginVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCaracteristicas()
        JaTemCadastro()

    }
    

    func configCaracteristicas(){
        
        goLabel.text = "Go"
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        receitasLabel.text = "Receitas"
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        
        imageTopLogo.image = UIImage(named: "topLogo")
        
        emailLabel.text = "E-mail"
        emailLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        textFieldEmail.placeholder = "Digite seu E-mail:"
        
        senhaLabel.text = "Senha"
        senhaLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        textFieldSenha.placeholder = "Digite sua Senha"
        
        esqueceuSenhaButton.setTitle("Esqueceu senha?", for: .normal)
        
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        
        ouLabel.text = "OU"
        
        riscoView1.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        riscoView2.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        riscoView3.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        
        
        
        loginGoogleButton.setTitle("Entrar com o Google", for: .normal)
        loginGoogleButton.setTitleColor(.black, for: .normal)
        loginGoogleButton.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 221/255, alpha: 1)
        
        imageLogoFundo.image = UIImage(named: "logoFundo")
        
    }
    
    func JaTemCadastro(){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(ciColor: .black), .font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        let attributedTitle = NSMutableAttributedString(string: "Não tem uma conta? ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .semibold)]
        attributedTitle.append(NSAttributedString(string: "Cadastre-se", attributes: boldAtts))
        fazerCadastroButton.setAttributedTitle(attributedTitle, for: .normal)
        fazerCadastroButton.setTitleColor(UIColor(red: 101/255, green: 33/255, blue: 165/255, alpha: 1), for: .normal)    }
    
    
    @IBAction func tappedLogin(_ sender: UIButton) {
    }
    
    
    
    @IBAction func tappedLoginGoogle(_ sender: UIButton) {
    }
    
    
    @IBAction func tappedFazerCadastroButton(_ sender: UIButton) {
    }
    
    
    }
   


