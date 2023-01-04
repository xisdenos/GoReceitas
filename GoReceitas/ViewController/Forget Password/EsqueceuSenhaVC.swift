//
//  EsqueceuSenhaVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class EsqueceuSenhaVC: UIViewController {
    
    
    @IBOutlet weak var voltatButton: UIButton!
    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var receitasLabel: UILabel!
    @IBOutlet weak var logoTopImage: UIImageView!
    @IBOutlet weak var informacaoLabel: UILabel!
    @IBOutlet weak var textFieldInformarEmail: UITextField!
    @IBOutlet weak var enviarButton: UIButton!
    
    var auth: Auth?
    var alert: AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        configCharacter()
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
    
    func configCharacter() {
        voltatButton.setImage(UIImage(named: "back11"), for: .normal)
        
        goLabel.text = "Go"
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        receitasLabel.text = "Receitas"
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logoTopImage.image = UIImage(named: "logoTop")
        
        informacaoLabel.text = ForgetPasswordsDescriptions.infoEmailLabel.rawValue
        informacaoLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        textFieldInformarEmail.placeholder = ForgetPasswordsDescriptions.emailPlaceholder.rawValue
        textFieldInformarEmail.delegate = self
        
        enviarButton.setTitle(ForgetPasswordsDescriptions.sendEmailLabel.rawValue, for: .normal)
        enviarButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        enviarButton.setTitleColor(.white, for: .normal)
        enviarButton.setTitleColor(.white.withAlphaComponent(0.40), for: .disabled)
        enviarButton.layer.cornerRadius = 10
        enviarButton.clipsToBounds = true
        enviarButton.isEnabled = false
        
    }
    func validacaoTextField(){
        let confirmarSenha:String = textFieldInformarEmail.text ?? ""
        if !confirmarSenha.isEmpty  {
            self.configbuttonEnable(true)
        }else{
            self.configbuttonEnable(false)
        }
        
    }
    private func configbuttonEnable(_ enable:Bool){
        if enable{
            self.enviarButton.setTitleColor(.white, for: .normal)
            self.enviarButton.isEnabled = true
        }else{
            self.enviarButton.setTitleColor(.lightGray, for: .normal)
            self.enviarButton.isEnabled = false
        }
    }
    
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func enviarButton(_ sender: UIButton) {
        
        let email:String = textFieldInformarEmail.text ?? ""
        self.auth?.sendPasswordReset(withEmail: email)
        
        self.alert?.alertInformation(title: "Heads up", message: "Email sent to reset password.",completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    
    
    
}
extension EsqueceuSenhaVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validacaoTextField()

        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true

    }
}
