//
//  Photo.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Photo


class Photo: Codable {
    var id: String
    var imageURL: URL
    
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "url_n"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(imageURL, forKey: .imageURL)
    }
}


// MARK: - Request


extension Photo {
    
    var imageRequest: Request<UIImage> {
        Request<UIImage>(imageURL, parse: Parse.image())
    }
}


// MARK: - Equatable


extension Photo: Equatable {
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id &&
        lhs.imageURL.absoluteString == rhs.imageURL.absoluteString &&
        lhs.image == rhs.image
    }
}


// MARK: - Hashable


extension Photo: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(imageURL.absoluteString)
        hasher.combine(image)
    }
}
