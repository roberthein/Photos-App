//
//  Location.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


// MARK: - Location Type


enum LocationType: CaseIterable, MenuType {
    case amsterdam
    case paris
    case london
    case newyork
    case tokyo
}


// MARK: - Icon


extension LocationType {
    
    var title: String? {
        switch self {
        case .amsterdam: return "AMS"
        case .paris: return "PRS"
        case .london: return "LON"
        case .newyork: return "NYC"
        case .tokyo: return "TKO"
        }
    }
    
    var icon: UIImage? { nil }
    var iconSelected: UIImage? { nil }
}


// MARK: - Coordinate


extension LocationType {
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .amsterdam: return CLLocationCoordinate2D(latitude: 52.3546448, longitude: 4.83375)
        case .paris: return CLLocationCoordinate2D(latitude: 48.8588536, longitude: 2.3119549)
        case .london: return CLLocationCoordinate2D(latitude: 51.5287714, longitude: -0.242022)
        case .newyork: return CLLocationCoordinate2D(latitude: 40.6976633, longitude: -74.1201051)
        case .tokyo: return CLLocationCoordinate2D(latitude: 35.5079384, longitude: 139.2080561)
        }
    }
}
