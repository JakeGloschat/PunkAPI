//
//  BeerList.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import UIKit

struct NetworkingController {
    
    static func fetchAllBeers(completion: @escaping (Result<[Beer], NetworkError>) -> Void) {
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
                let beers = try JSONDecoder().decode([Beer].self, from: data)
                completion(.success(beers))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchRandomBeer(completion: @escaping (Result<Beer, NetworkError>) -> Void) {
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
                let topLevelArray = try JSONDecoder().decode([Beer].self, from: data)
                let beer = topLevelArray[0]
                completion(.success(beer))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let item = item else { completion(.success(UIImage(named: "Last_Buca_Ref")!)) ; return }
        guard let finalURL = URL(string: item) else { completion(.failure(.invalidURL)) ; return }
        print("Image Fetch Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else { completion(.failure(.invalidStatusCode)) ; return }
            
            guard let data = data, !data.isEmpty else { completion(.failure(.noData)) ; return }
            
            guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
            completion(.success(image))
        }.resume()
    }
}
