//
//  AlertController.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/21/22.
//

import UIKit

class AlertController: NSObject {
    enum TypeImageSelected{
        case camera
        case library
        case cancel
    }
    
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
        
    func alertEditPhoto(completion: @escaping (_ option: TypeImageSelected) -> Void){

        let alertController: UIAlertController = UIAlertController(title: "Selecione uma das opções abaixo", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { action in
            completion(.camera)
        }
        
        let library = UIAlertAction(title: "Biblioteca", style: .default) { action in
            completion(.library)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            completion(.cancel)
            
        }
        
        
        alertController.addAction(camera)
        alertController.addAction(library)
        alertController.addAction(cancel)
        controller.present(alertController, animated: true)
        
        
    }
        
    }

