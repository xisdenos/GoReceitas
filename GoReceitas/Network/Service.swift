//
//  Service.swift
//  GoReceitas
//
//  Created by Igor Fernandes on 06/12/22.
//

import Foundation

struct APIEndpoints {
    static let list = "/list"
}

struct APIConstants {
    static let base_url = "https://tasty.p.rapidapi.com/recipes"
    static let api_key = "670a8a751emsh93bbc953839869ep1ec5efjsn4076d2edbe1a"
}

class Service {
    static func getFoodList(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: APIConstants.base_url + APIEndpoints.list) else { return }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.api_key, forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            // no data, error occurred!
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(Foods.self, from: data)
//                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}

/*
 const options = {
   method: 'GET',
   url: 'https://tasty.p.rapidapi.com/recipes/auto-complete',
   params: {prefix: 'chicken soup'},
   headers: {
     'X-RapidAPI-Key': '670a8a751emsh93bbc953839869ep1ec5efjsn4076d2edbe1a',
     'X-RapidAPI-Host': 'tasty.p.rapidapi.com'
   }
 };
 */
