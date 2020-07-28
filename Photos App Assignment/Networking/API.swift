//
//  API.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import CoreLocation


// MARK: - URL


extension URL {
    static func photos(for location: LocationType, page: Int = 0) -> URL {
        FlickrAPI.photoSearchURL(location: location, perPage: 100, page: page)
    }
}


// MARK: - API


struct FlickrAPI {
    static let base = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6a87918fc342cc45e7ca4baf6ea61fec&extras=url_n"
    
    static func photoSearchURL(location: LocationType, perPage: Int, page: Int) -> URL {
        let urlString = base + "&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&accuracy=11&format=json&nojsoncallback=1&per_page=\(perPage)&page=\(page)"
        
        return URL(string: urlString)!
    }
}
