//
//  PhotoResponse.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Photo Response


struct PhotoResponse: Codable {
    let photos: [Photo]
    
    enum ParentCodingKeys: String, CodingKey {
        case photos
    }
    
    enum CodingKeys: String, CodingKey {
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let parent = try decoder.container(keyedBy: ParentCodingKeys.self)
        let container = try parent.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        
        let _photos = try container.decode([Photo?].self, forKey: .photo)
        photos = _photos.compactMap { $0 }
    }
    
    func encode(to encoder: Encoder) throws {
        var parent = encoder.container(keyedBy: ParentCodingKeys.self)
        var container = parent.nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        
        try container.encode(photos, forKey: .photo)
    }
}


// MARK: - Request


extension Request {
    
    static func photos(for location: LocationType, page: Int = 0) -> Request<PhotoResponse> {
        Request<PhotoResponse>(.photos(for: location, page: page), parse: Parse.data())
    }
}
