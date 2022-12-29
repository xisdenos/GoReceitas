//
//  ViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 19/08/22.
//

import UIKit
import FirebaseAuth

import FirebaseStorage
import FirebaseFirestore
import Firebase


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var buttonGoOut: UIButton!
    @IBOutlet weak var buttonEditPhoto: UIButton!
    
    
    var auth:Auth?
    var alert: AlertController?
    let imagePicker: UIImagePickerController = UIImagePickerController()
    let storage = Storage.storage().reference()
    let firestore = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        imageRound()
        exitButtonBorder()
        cornerRadiusElements()
        self.view.backgroundColor = .viewBackgroundColor
        configImagePicker()
        //        imageProfile.image = imageProfile.image
        textUsername.isUserInteractionEnabled = false
        textEmail.isUserInteractionEnabled = false
        updateImage()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func tappedEditPhoto(_ sender: UIButton) {
        
        
        
        self.alert?.alertEditPhoto(completion: { option in
            switch option {
            case .camera:
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true)
                
            case .library:
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true)
                
            case .cancel:
                break
            }
        })
        
    }
    
    @IBAction func tapChangePasswordScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changePassword") as! ChangePasswordViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func tapChangeEmailScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "changeEmail")
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    @IBAction func tappedExit(_ sender: UIButton) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defauts = UserDefaults.standard
            defauts.set(false, forKey: "isUserSignedIn ")
            self.dismiss(animated: true,completion: nil)
        } catch {
            self.alert?.alertInformation(title: "Atenção", message: "Erro ao Sair")
        }
        
        
        let vc = UIStoryboard(name: "LoginVC", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func imageRound() {
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius =  75
    }
    
    func cornerRadiusElements(){
        textUsername.layer.cornerRadius = 10
        textEmail.layer.cornerRadius = 10
        changeEmailButton.layer.cornerRadius = 10
        buttonChangePassword.layer.cornerRadius = 10
    }
    
    func exitButtonBorder() {
        buttonGoOut.backgroundColor = .clear
        buttonGoOut.layer.cornerRadius = 10
        buttonGoOut.layer.borderWidth = 1
        buttonGoOut.layer.borderColor = UIColor.red.cgColor
    }
    func configImagePicker(){
        imagePicker.delegate = self
    }
    
    func updateImage(){
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageProfile.image = image
            }
        }
        task.resume()
    }
    
    
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageProfile.image = image
            NotificationCenter.default.post(name: .updateImage, object: imageProfile.image)
            
            guard let imageData = image.pngData() else { return }
            
            
            
            storage.child("images/file.png").putData(imageData,metadata: nil) { _, error in
                guard error == nil else {
                    print("failed to upload")
                    return
                }
                self.storage.child("images/file.png").downloadURL { url, error in
                    guard let url = url, error == nil else {return}
                    let urlString = url.absoluteString
                    
                    DispatchQueue.main.async {
                        self.imageProfile.image = image
                    }
                    
                    print("Download URL: \(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                    
                    if let id = self.auth?.currentUser?.uid {
                        self.firestore.collection("usuarios").document(id).setData([
                            "image":urlString,
                            
                        ])
                    }
                    
                    
                }
            }
            
        }
        picker.dismiss(animated: true)
        
    }
    
    
    
    
    
}
extension NSNotification.Name {
    static let updateImage = Notification.Name("updateImage")
    static let updateImageEmail = Notification.Name("updateImageEmail")
    static let updateImageSenha = Notification.Name("updateImageSenha")
}
