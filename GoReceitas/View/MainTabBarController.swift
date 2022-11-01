//
//  MainTabBarController.swift
//  GoReceitas
//
//  Created by Franklin  Stilhano on 10/31/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setTabBarViewControllers()
    }
    
   
    let homeVC = UINavigationController(rootViewController: UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeVC"))
        let searchVC = UINavigationController(rootViewController: UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchVC"))
        let favoritesVC = UINavigationController(rootViewController: UIStoryboard(name: "FavoriteVC", bundle: nil).instantiateViewController(withIdentifier: "FavoriteHomeVC"))
        let profileVC = UINavigationController(rootViewController: UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profile"))
         
         private func setTabBarViewControllers() {
         setViewControllers([homeVC, searchVC, favoritesVC, profileVC], animated: true)
         }
         
        
        
    }


