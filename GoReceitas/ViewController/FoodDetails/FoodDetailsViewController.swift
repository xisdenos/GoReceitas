//
//  FoodDetailsViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    
    var foodDetailsView: FoodDetailsView = FoodDetailsView()
    
    override func loadView() {
        super.loadView()
        view = foodDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
