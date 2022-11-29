//
//  NewHomeViewController.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/11/22.
//

import UIKit

class NewHomeViewController: UIViewController {
    
    lazy var pageControlProg: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.pageIndicatorTintColor = .white
        pc.currentPageIndicatorTintColor = .purple
        pc.isUserInteractionEnabled = false
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        return pc
    }()
    
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
        tableView.separatorStyle = .none
        tableView.register(CategoryTagsTableViewCell.nib(), forCellReuseIdentifier: CategoryTagsTableViewCell.identifier)
        tableView.register(TryItOutTableViewCell.nib(), forCellReuseIdentifier: TryItOutTableViewCell.identifier)
        tableView.register(PopularFoodsTableViewCell.nib(), forCellReuseIdentifier: PopularFoodsTableViewCell.identifier)
    }
    
    @objc func allTagsTapped() {
        print(#function)
    }
}

extension NewHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTagsTableViewCell.identifier) as? CategoryTagsTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TryItOutTableViewCell.identifier) as? TryItOutTableViewCell else { return UITableViewCell() }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularFoodsTableViewCell.identifier) as? PopularFoodsTableViewCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Categorias"
        case 1:
            return "Experimente"
        case 2:
            return "Popular"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else if indexPath.section == 1 {
            return 250
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            guard let header = view as? UITableViewHeaderFooterView else { return }
            let allTagsButton: UIButton = UIButton(frame: CGRect(x: header.frame.midX + 100, y: 0, width: 100, height: 30))
            allTagsButton.setTitle("All Tags", for: .normal)
            allTagsButton.setTitleColor(.systemPurple, for: .normal)
            allTagsButton.addTarget(self, action: #selector(allTagsTapped), for: .touchUpInside)
            
            header.addSubview(allTagsButton)
            
            header.textLabel?.textColor = UIColor.systemPurple
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            header.textLabel?.frame = header.bounds
        }
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.systemPurple
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
//        view.addSubview(pageControlProg)
//        view.backgroundColor = .green
//        pageControlProg.backgroundColor = .red
//        return view
//    }
}
