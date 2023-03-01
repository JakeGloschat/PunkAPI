//
//  BeerList.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct BeerList {
    
    static func fetchAllBeers(completion: @escaping (Result<[TopLevel], NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.beersBaseURL) else { completion(.failure(.invalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.BeerList.allBeersPath)
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Fetch Entire Beer List Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Entire Beer List Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                let topLevel = try JSONDecoder().decode([TopLevel].self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.UnableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchRandomBeer(completion: @escaping (Result<[TopLevel], NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.BeerList.beersBaseURL) else { completion(.failure(.invalidURL)) ; return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.BeerList.randomBeerPath)
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Fetch Random Beer Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Random beer Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                let topLevel = try JSONDecoder().decode([TopLevel].self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.UnableToDecode))
                return
            }
        }.resume()
        
    }
}
