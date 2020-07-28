//
//  Network.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Network


let Network = URLSession.shared

extension URLSession {
    
    
    // MARK: Load
    

    func load<T>(_ request: Request<T>, completion: @escaping (Result<T, Error>) -> ()) {
        
        dataTask(with: request.url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unknown))
                }
                return
            }
            
            guard (200 ... 299).contains(response.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.statusCode(response.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            let parsedData = request.parse(data)
            
            DispatchQueue.main.async {
                completion(parsedData)
            }
            
        }.resume()
    }
}
