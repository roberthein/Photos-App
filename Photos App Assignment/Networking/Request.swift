//
//  Request.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Request


struct Request<T> {
    let url: URL
    var parse: (Data) -> Result<T, Error>
    
    init(_ url: URL, parse: @escaping (Data) -> Result<T, Error>) {
        self.url = url
        self.parse = parse
    }
}


// MARK: - Parse


struct Parse {
    
    
    // MARK: Data
    

    static func data<T: Codable>() -> ((Data) -> Result<T, Error>) {
        return { data in
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                return .failure(NetworkError.noData)
            }
        }
    }
    
    
    // MARK: Image
    

    static func image() -> ((Data) -> Result<UIImage, Error>) {
        return { data in
            guard let image = UIImage(data: data) else {
                return .failure(NetworkError.notImageData)
            }
            
            return .success(image)
        }
    }
}
