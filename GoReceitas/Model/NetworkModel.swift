//
//  NetworkModel.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 28/12/22.
//

import Foundation

protocol NetworkModelProtocol: AnyObject {
    func success()
    func error(message: String)
    func startLoading()
    func stopLoading()
}

struct NetworkModel {
    private var service: Service = Service()
    
    weak var delegate: NetworkModelProtocol?
    
    func fetchTryItOut(completion: @escaping (Result<[FoodResponse], Error>) -> Void) {
        delegate?.startLoading()
        service.getFoodList { result in
            switch result {
            case .success(let success):
                let filteredArray = success.results.filter({ $0.yields != nil })
                completion(.success(filteredArray))
                delegate?.success()
                self.delegate?.stopLoading()
            case .failure(let failure):
                completion(.failure(failure))
                delegate?.error(message: failure.localizedDescription)
                self.delegate?.stopLoading()
            }
        }
    }
    
    func fetchTagsList(completion: @escaping (Result<[TagsResponse], Error>) -> Void) {
//        delegate?.startLoading()
        service.getTagsList { result in
            switch result {
            case .success(let success):
                completion(.success(success.results))
            case .failure(let failure):
                completion(.failure(failure))
//                delegate?.error(message: failure.localizedDescription)
                self.delegate?.stopLoading()
            }
        }
    }
    
    func filterRecipes(popularResponses: [PopularResponse]) -> [FoodResponse] {
      var recipes: [FoodResponse] = []

      for response in popularResponses {
        if let item = response.item, let foodResponses = item.recipes {
          recipes += foodResponses
        }
      }

      return recipes
    }
    
    func fetchPopular(completion: @escaping (Result<[FoodResponse], Error>) -> Void) {
        service.getPopularList { result in
            switch result {
            case .success(let success):
                if let recipeResults = success.results {
                    let recipes = filterRecipes(popularResponses: recipeResults)
                    completion(.success(recipes))
                }
            case .failure(let failure):
                completion(.failure(failure))
                print(failure)
            }
        }
    }
}
