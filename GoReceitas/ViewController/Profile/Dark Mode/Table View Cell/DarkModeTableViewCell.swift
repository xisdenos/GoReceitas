//
//  DarkModeTableViewCell.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 04/01/23.
//

import UIKit

class DarkModeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var darkModeLbl: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    static let identifier: String = String(describing: DarkModeTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configVisualElements()
    }
    
    func configVisualElements() {
        darkModeLbl.text = "Dark mode"
        darkModeSwitch.isOn = false
    }
    
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        NotificationCenter.default.post(name: Notification.Name("SwitchChanged"), object: sender)
    }
}
