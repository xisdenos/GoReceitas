//
//  Login.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 8/28/22.
//

import UIKit

class Login: UIViewController {
    
    @IBOutlet weak var googleSignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedGoogleSignInButton(_ sender: UIButton) {
        print("tapped")
    }
}
