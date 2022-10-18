//
//  EsqueceuSenhaVC.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/17/22.
//

import UIKit

class EsqueceuSenhaVC: UIViewController {
    

    @IBOutlet weak var voltatButton: UIButton!
    
    @IBOutlet weak var goLabel: UILabel!
    
    @IBOutlet weak var receitasLabel: UILabel!
    
    @IBOutlet weak var logoTopImage: UIImageView!
    
    @IBOutlet weak var informacaoLabel: UILabel!
    
    @IBOutlet weak var textFieldInformarEmail: UITextField!
    
    @IBOutlet weak var enviarButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func configCaracter() {
        voltatButton.setImage(UIImage(named: "back"), for: .normal)
        
        goLabel.text = "Go"
        goLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        goLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        
        receitasLabel.text = "Receitas"
        receitasLabel.textColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        receitasLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logoTopImage.image = UIImage(named: "logoTop")
        
        textFieldInformarEmail.placeholder = "Digite seu Email"
        
        enviarButton.setTitle("Enviar", for: .normal)
        enviarButton.backgroundColor = UIColor(red: 149/255, green: 1/255, blue: 239/255, alpha: 1)
        enviarButton.setTitleColor(.white, for: .normal)
        enviarButton.layer.cornerRadius = 10
        enviarButton.clipsToBounds = true
        
    }
    

    
    @IBAction func tappedBackButton(_ sender: UIButton) {
    }
    
    
    @IBAction func enviarButton(_ sender: UIButton) {
    }
    



}
