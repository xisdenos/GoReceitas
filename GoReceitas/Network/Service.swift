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
}

struct APIConstants {
    static let base_url = "https://tasty.p.rapidapi.com"
    static let api_key = "e920523487msh477e5e672017785p109515jsn8a5893396a20"
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
    
    // search
    func searchFoodWith(term: String, completion: @escaping (Result<Foods, Error>) -> Void) {
        guard var urlComp = URLComponents(string: APIConstants.base_url + APIEndpoints.foodList) else { return }
        urlComp.queryItems = [
            URLQueryItem(name: "q", value: term)
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
