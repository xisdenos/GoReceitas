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
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    @IBOutlet weak var buttonGoOut: UIButton!
    @IBOutlet weak var buttonEditPhoto: UIButton!
    
    @IBOutlet weak var darkModeButton: UIButton!
    
    
    var auth:Auth?
    var alert: AlertController?
    let imagePicker: UIImagePickerController = UIImagePickerController()
    let storage = Storage.storage().reference()
    let firestore = Firestore.firestore()
    var user: [User] = []
    var currentUser = Auth.auth().currentUser
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = AlertController(controller: self)
        self.auth = Auth.auth()
        imageRound()
        exitButtonBorder()
        cornerRadiusElements()
        self.view.backgroundColor = .viewBackgroundColor
        configImagePicker()
        textUsername.isUserInteractionEnabled = false
        textEmail.isUserInteractionEnabled = false
        updateImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        getUserData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //   self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func tappedDarkMode(_ sender: Any) {
        let controller = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "dm") 
        self.navigationController?.pushViewController(controller, animated: true)
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
        imageProfile.layer.cornerRadius =  70
    }
    
    func cornerRadiusElements(){
        textUsername.layer.cornerRadius = 10
        textEmail.layer.cornerRadius = 10
        changeEmailButton.layer.cornerRadius = 10
        buttonChangePassword.layer.cornerRadius = 10
        darkModeButton.layer.cornerRadius = 10
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
    
    
    
    func getUserData(){
        firestore.collection("usuarios").getDocuments { snapchot, error in
            if error == nil {
                if let snapchot {
                    DispatchQueue.main.async {
                        self.user = snapchot.documents.map({ document in
                            print("bola \(self.currentUser?.email)")
                            return User(nome: document["nome"] as? String ?? "",
                                        email: document["email"] as? String ?? "",
                        image: document["image"] as? String ?? "")
                        })
                        self.populateView(index: self.getIndex(email: self.currentUser?.email ?? ""))
                        print(self.currentUser?.email)
                        print(self.user)
                    }
                }
            }
        }
    }
    
    
    func populateView(index: Int){
        textEmail.text = user[index].email
        textEmail.textColor = .lightGray
        textUsername.text = user[index].nome
        textUsername.textColor = .lightGray
        let url = URL(string: user[index].image) ?? URL(fileURLWithPath: "")
        imageProfile.af.setImage(withURL: url)
    }
    
    func getIndex(email: String) -> Int {
        let index = user.firstIndex { $0.email == email } ?? 0
        print("banana \(index)")
            return index
    
    }
    

    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageProfile.image = image
        
            guard let imageData = image.pngData() else { return }
            
            let currentUser = Favorite.getCurrentUserEmail
            
            storage.child("images/file.png").putData(imageData,metadata: nil) { _, error in
                guard error == nil else {
                    print("failed to upload", error?.localizedDescription)
                    return
                }
                self.storage.child("images/file.png").downloadURL { url, error in
                    guard let url = url, error == nil else {return}
                    let urlString = url.absoluteString

                    DispatchQueue.main.async {
                        self.imageProfile.image = image
                    }

                    print("Download URL: \(urlString)")

                    let doc = self.firestore.collection("usuarios").document(currentUser)
                    doc.updateData([
                        "image": urlString
                    ])
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
