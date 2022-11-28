//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class NewHomeViewController: UIViewController {
    
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        userProfilePictureImageView.image = UIImage(systemName: "person")
        configTableView()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
