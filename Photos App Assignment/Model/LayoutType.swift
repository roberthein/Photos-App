//
//  LayoutType.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Layout Type


enum LayoutType: CaseIterable, MenuType {
    case inspirational
    case grid
    case rectangle
}


// MARK: - Icon


extension LayoutType {
    
    var title: String? { nil }
    
    var icon: UIImage? {
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        
        switch self {
        case .grid:
            return UIImage(systemName: "square.grid.3x2", withConfiguration: iconConfig)
        case .inspirational:
            return UIImage(systemName: "rectangle.3.offgrid", withConfiguration: iconConfig)
        case .rectangle:
            return UIImage(systemName: "rectangle.grid.1x2", withConfiguration: iconConfig)
        }
    }
    
    var iconSelected: UIImage? {
        let iconConfigBold = UIImage.SymbolConfiguration(pointSize: 23, weight: .black)
        
        switch self {
        case .grid:
            return UIImage(systemName: "square.grid.3x2.fill", withConfiguration: iconConfigBold)
        case .inspirational:
            return UIImage(systemName: "rectangle.3.offgrid.fill", withConfiguration: iconConfigBold)
        case .rectangle:
            return UIImage(systemName: "rectangle.grid.1x2.fill", withConfiguration: iconConfigBold)
        }
    }
}


// MARK: - Collection View Layout


extension LayoutType {
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        switch self {
        case .grid:
            return .grid
        case .inspirational:
            return .inspirational
        case .rectangle:
            return .rectangle
        }
    }
}
