//
//  Service.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/12/22.
//

import Foundation

struct APIEndpoints {
    static let foodList = "/recipes/list"
    static let tags = "/tags/list"
    static let getMoreInfo = "/recipes/get-more-info"
    static let similarFoods = "/recipes/list-similarities"
    static let popular = "/feeds/list"
}

struct APIConstants {
    static let base_url = "https://tasty.p.rapidapi.com"
    static let api_key = "feb7743f0emsha633dde2780e25fp1df0e8jsn1115b5b7dc48"
}

enum FoodError: Error {
    case noFoodFound
    case invalidFoodId
}

class Service {
    func getFoodList(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: APIConstants.base_url + APIEndpoints.foodList) else { return }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPopularList(completion: @escaping (Result<Popular, Error>) -> Void) {
        guard let url = URL(string: APIConstants.base_url + APIEndpoints.popular) else { return }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(Popular.self, from: data)
                    completion(.success(json))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    // search
    func searchFoodWith(term: String, completion: @escaping (Result<Foods, FoodError>) -> Void) {
        guard var urlComp = URLComponents(string: APIConstants.base_url + APIEndpoints.foodList) else { return }
        urlComp.queryItems = [
            URLQueryItem(name: "q", value: term)
        ]
        
        guard let urlCompUrl = urlComp.url else { return }
        var request = URLRequest(url: urlCompUrl)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        request.timeoutInterval = 7
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            if let error = error as? URLError, error.code == .timedOut {
                // show error message to user
                print("network call timed out")
            } else {
                if let data {
                    do {
                        let json = try JSONDecoder().decode(Foods.self, from: data)
                        if json.count == 0 || json.results.isEmpty {
                            completion(.failure(.noFoodFound))
                        } else {
                            completion(.success(json))
                        }
                    } catch {
                        completion(.failure(.invalidFoodId))
                    }
                }
            }
        }.resume()
    }
    
    func getTagSelectedWith(tagName: String, completion: @escaping (Result<Foods, Error>) -> Void) {
        // another way of using query instead of hardcoded
        guard var urlComp = URLComponents(string: APIConstants.base_url + APIEndpoints.foodList) else { return }
        urlComp.queryItems = [
            URLQueryItem(name: "tags", value: tagName)
        ]
        
        guard let urlCompUrl = urlComp.url else { return }
        var request = URLRequest(url: urlCompUrl)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getTagsList(completion: @escaping (Result<Tags, Error>) -> Void) {
        guard let url = URL(string: APIConstants.base_url + APIEndpoints.tags) else { return }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Tags.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getMoreInfo(id: Int, completion: @escaping (Result<FoodDetailsInfo, Error>) -> Void) {
        // another way of using query instead of hardcoded
        guard var urlComp = URLComponents(string: APIConstants.base_url + APIEndpoints.getMoreInfo) else { return }
        urlComp.queryItems = [
            URLQueryItem(name: "id", value: String(id))
        ]
        
        guard let urlCompUrl = urlComp.url else { return }
        var request = URLRequest(url: urlCompUrl)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(FoodDetailsInfo.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSimilarFoods(id: Int, completion: @escaping (Result<Foods, Error>) -> Void) {
        // another way of using query instead of hardcoded
        guard var urlComp = URLComponents(string: APIConstants.base_url + APIEndpoints.similarFoods) else { return }
        urlComp.queryItems = [
            URLQueryItem(name: "recipe_id", value: String(id))
        ]
        
        guard let urlCompUrl = urlComp.url else { return }
        var request = URLRequest(url: urlCompUrl)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
