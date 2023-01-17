//
//  HomeViewModel.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 17/01/23.
//

import Foundation
import FirebaseDatabase

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func error(message: String)
    func startLoading()
    func stopLoading()
    func successTags(_ tagResponse: [FoodResponse], tagsController: TagsResultsViewController)
}

class HomeViewModel {
    private(set) var tagsList: [TagsResponse] = [TagsResponse]()
    private(set) var tryItOut: [FoodResponse] = [FoodResponse]()
    private(set) var popularList: [FoodResponse] = [FoodResponse]()
    
    private var service: Service = Service()
    private var successfulRequests = 0
    private var model = NetworkModel()
    
    private weak var delegate: HomeViewModelDelegate?
    
    let database = Database.database().reference()
    
    public var isPopularListEmpty: Bool {
        return popularList.isEmpty
    }
    
    init(_ service: Service = Service()) {
        self.service = service
    }
    
    func set(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
 
    func fetchData(completion: @escaping () -> Void) async {
        await model.fetchTryItOut { [weak self] result in
            switch result {
            case .success(let success):
                self?.tryItOut = success
                self?.successfulRequests += 1
                if self?.successfulRequests == 3 {
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
        await model.fetchTagsList { [weak self] tags in
            switch tags {
            case .success(let tags):
                self?.tagsList = tags
                self?.successfulRequests += 1
                if self?.successfulRequests == 3 {
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
        await model.fetchPopular { [weak self] result in
            switch result {
            case .success(let success):
                self?.popularList = success
                self?.successfulRequests += 1
                if self?.successfulRequests == 3 {
                    completion()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTags(_ tagsResponse: TagsResponse, tagsController: TagsResultsViewController) {
        service.getTagSelectedWith(tagName: tagsResponse.name) { tagResult in
            switch tagResult {
            case .success(let tags):
                DispatchQueue.main.async {
                    let filteredArray = tags.results.filter({ $0.yields != nil })
                    tagsController.title = tagsResponse.display_name
                    tagsController.configureFoodInformation(foodsInfo: filteredArray)
                    tagsController.activityIndicator.stopAnimating()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
   
    func fetchMoreInfo(_ food: FoodResponse, completion: @escaping (Result<FoodDetailsInfo, Error>) -> Void) {
        service.getMoreInfo(id: food.id) { details in
            switch details {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchSimilarFoods(_ food: FoodResponse, completion: @escaping (Result<[FoodResponse], Error>) -> Void) {
        service.getSimilarFoods(id: food.id, completion: { result in
            switch result {
            case .success(let success):
                print(success)
                completion(.success(success.results))
            case .failure(let failure):
                completion(.failure(failure))
                print(failure)
            }
        })
    }
}


