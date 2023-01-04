//
//  FoodDetailsViewController.swift
//  GoReceitas
//
//  Created by Lucas Pinto on 31/10/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

enum DetailsSections: Int {
    case details = 0
    case description = 1
    case recommended = 2
}

class FoodDetailsViewController: UIViewController {
    
//    private var isFavorited: Bool = false
    
    let database = Database.database().reference()
    
    var foodId: Int?
    
    private var service: Service = Service()
    private var foodDetails: FoodDetailsInfo?
    private var recommendedFoods: [FoodResponse] = [FoodResponse]()
    public var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    lazy var foodDetailsView: FoodDetailsView = {
        let foodview = FoodDetailsView()
        foodview.purpheHearthView.delegate = self
        foodview.tableView.delegate = self
        foodview.tableView.dataSource = self
        return foodview
    }()
    
    public func configureFoodInformation(foodDetails: FoodDetailsInfo) {
        self.foodDetails = foodDetails
        DispatchQueue.main.async { [weak self] in
            self?.foodDetailsView.foodImageView.loadImageUsingCache(withUrl: foodDetails.thumbnail_url)
            self?.foodDetailsView.topFadedLabel.setTitle(foodDetails.name, for: .normal)
            self?.foodDetailsView.configure(prepTimeText: String(foodDetails.yields ?? "N/A"))
            self?.foodDetailsView.tableView.reloadData()
        }
    }
    
    public func configureRecommendedFoods(foods: [FoodResponse]) {
        self.recommendedFoods = foods
        DispatchQueue.main.async { [weak self] in
            self?.foodDetailsView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        checkHeartStatus()
    }
    
    override func loadView() {
        super.loadView()
        view = foodDetailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.tintColor = .textColorDefault
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    func checkHeartStatus() {
        let ref = Database.database().reference()
        let userEmail = Favorite.getCurrentUserEmail
        
        if let foodId {
            ref.child("users/\(userEmail)/favorites").child(String(foodId)).observeSingleEvent(of: .value) { snapshot in
                if let dictionary = snapshot.value as? [String: Any] {
                    
                    // Iterate over the dictionary of recipes
                    for item in dictionary {
                        // get the values: ex "Easy Chocolate Rugelach" = { "name": "Easy Chocolate Rugelach" }
                        let favoriteItem = item.value as! [String: Any]
                        let favorite = favoriteItem["isFavorited"] as! Bool
                        
                        self.foodDetailsView.purpheHearthView.isActive = favorite

                        favorite == true ? self.foodDetailsView.purpheHearthView.hearthButton.setImage(UIImage(named: "heart-fill"), for: .normal) : self.foodDetailsView.purpheHearthView.hearthButton.setImage(UIImage(named: "heart-empty"), for: .normal)
                    }
                }
            }
        }
    }
}

extension FoodDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
            if foodDetails != nil {
                if let nutrition = foodDetails?.nutrition {
                    cell.configure(nutritions: nutrition)
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stopAnimating()
                        self?.foodDetailsView.tableView.isHidden = false
                        self?.foodDetailsView.topFadedLabel.isHidden = false
                        self?.foodDetailsView.purpheHearthView.isHidden = false
                        self?.foodDetailsView.timeView.isHidden = false
                    }
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            if foodDetails != nil {
                if let recipeInstructions = foodDetails?.instructions {
                    // A api nos retorna um array de instruções separadas.
                    // Para poder junta-las, é preciso mapear o array e usar o
                    // método joined para transformar em uma só string
                    let newArray = recipeInstructions.map({ $0.display_text })
                    let instruction = newArray.joined(separator: "\n\n")
                    cell.configure(description: instruction)
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedFoodsTableViewCell.identifier, for: indexPath) as! RecommendedFoodsTableViewCell
            cell.delegate = self
            // TODO: Create emtpy cell state
            cell.setup(foods: recommendedFoods)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case DetailsSections.details.rawValue:
            return 100
        case DetailsSections.recommended.rawValue:
            return 250
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case DetailsSections.details.rawValue:
            return "Details"
        case DetailsSections.description.rawValue:
            return "Instructions"
        case DetailsSections.recommended.rawValue:
            return "You might also like"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .textColorDefault
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
    }
}

extension FoodDetailsViewController: DefaultCellsDelegate {
    func didFavoriteItem(itemSelected: FoodResponse, favorited: Bool) {
        Favorite.favoriteItem(itemSelected: itemSelected, favorited: favorited, database: database)
    }
    
    
    func didTapDefaultFoodCell(food: FoodResponse) {
        let controller = FoodDetailsViewController()
        controller.foodId = food.id
        navigationController?.pushViewController(controller, animated: true)
        
        DispatchQueue.main.async { [weak self] in
            controller.activityIndicator.startAnimating()
            controller.foodDetailsView.tableView.isHidden = true
            controller.foodDetailsView.topFadedLabel.isHidden = true
            controller.foodDetailsView.purpheHearthView.isHidden = true
            controller.foodDetailsView.timeView.isHidden = true
            self?.service.getMoreInfo(id: food.id) { details in
                switch details {
                case .success(let success):
                    controller.configureFoodInformation(foodDetails: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
            self?.service.getSimilarFoods(id: food.id, completion: { result in
                switch result {
                case .success(let success):
                    controller.configureRecommendedFoods(foods: success.results)
                case .failure(let failure):
                    print(failure)
                }
            })
        }
    }
}

extension FoodDetailsViewController: PurpleHeartViewProtocol {
    func didTapHeartButton(isActive: Bool) {
        let userEmail = Favorite.getCurrentUserEmail
        guard let foodId else { return }
        let id = foodDetails?.id ?? 0
        let name = foodDetails?.name ?? ""
        let cook_time_minutes = foodDetails?.cook_time_minutes ?? 0
        let prep_time_minutes = foodDetails?.prep_time_minutes ?? 0
        let yields = foodDetails?.yields ?? ""
        let thumbnail_url = foodDetails?.thumbnail_url ?? ""
        let instructions = foodDetails?.instructions ?? nil
        let nutrition = foodDetails?.nutrition ?? nil
        
        let foodResponse = FoodResponse(id: id, name: name, thumbnail_url: thumbnail_url, cook_time_minutes: cook_time_minutes, prep_time_minutes: prep_time_minutes, yields: yields)
        
        database.child("users/\(userEmail)").child("favorites").observeSingleEvent(of: .value) { snapshot in
            if snapshot.hasChild(String(foodId)) {
                Favorite.unfavoriteItem(at: foodResponse, database: self.database)
            } else {
                // self.delegate?.didFavoriteItem(itemSelected: foodSelected, favorited: isActive)
                let details = FoodDetailsInfo(id: id, name: name, cook_time_minutes: cook_time_minutes, prep_time_minutes: prep_time_minutes, yields: yields, thumbnail_url: thumbnail_url, nutrition: nutrition, instructions: instructions)

                let favArray: [FoodDetailsInfo] = [details]

                let mappedArray = favArray.map { ["name": $0.name, "yields": $0.yields ?? "n/a", "image": $0.thumbnail_url, "isFavorited": isActive, "id": $0.id, "cook_time_minutes": $0.cook_time_minutes ?? 0, "prep_time_minutes": $0.prep_time_minutes ?? 0] }

                // create a dictionary of arrays with the key being food.name
                let dictionary = Dictionary(uniqueKeysWithValues: mappedArray.map { ($0["name"] as! String, $0) })

                // database.child("users/\(userEmail)").child("favorites").child(String(itemSelected.id)).updateChildValues(dictionary)
                self.database.child("users/\(userEmail)").child("favorites").child(String((details.id))).setValue(dictionary)
            }
        }
    }
}
