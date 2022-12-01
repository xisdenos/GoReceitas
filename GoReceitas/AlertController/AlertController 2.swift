//
//  AlertController.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/21/22.
//

import UIKit

class AlertController: NSObject {
    
    let controller: UIViewController
    init(controller : UIViewController){
        self.controller = controller
    }
    func alertInformation(title:String, message:String, completion: (() -> Void)? = nil){
            let alertController : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel) { acao in completion?()
                
            }
            alertController.addAction(ok)
            controller.present(alertController, animated: true)
        }
        
        
    }

