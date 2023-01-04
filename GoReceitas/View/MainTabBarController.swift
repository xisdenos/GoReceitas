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
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("SwitchChanged"), object: nil)
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
    
    @objc func handleNotification(_ notification: Notification) {
        if let sender = notification.object as? UISwitch {
            if sender.isOn {
                overrideUserInterfaceStyle = .dark
            } else {
                overrideUserInterfaceStyle = .light
            }
        }
    }
    
   
    let homeVC = UINavigationController(rootViewController: UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "newHome"))
        let searchVC = UINavigationController(rootViewController: UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "searchVC"))
        let favoritesVC = UINavigationController(rootViewController: UIStoryboard(name: "FavoriteVC", bundle: nil).instantiateViewController(withIdentifier: "FavoriteHomeVC"))
        let profileVC = UINavigationController(rootViewController: UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profile"))
         
         private func setTabBarViewControllers() {
         setViewControllers([homeVC, searchVC, favoritesVC, profileVC], animated: true)
         }
    }


