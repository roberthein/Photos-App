//
//  Layouts.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Collection View Layouts


extension UICollectionViewLayout {
    
    
    // MARK: Grid Layout
    
    
    static let grid = UICollectionViewCompositionalLayout { section, environment in
        let margin: CGFloat = 5
        let itemsPerRow: CGFloat = 4
        
        /// Row™
        /// +----+ +----+ +----+
        /// |    | |    | |    |
        /// +----+ +----+ +----+
        let rowItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/itemsPerRow), heightDimension: .fractionalHeight(1)))
        rowItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: 0)
        
        
        /// Container Group
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/itemsPerRow)),
            subitems: [rowItem]
        )
        containerGroup.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: 0, bottom: 0, trailing: margin)
        
        return NSCollectionLayoutSection(group: containerGroup)
    }
    
    
    // MARK: Inspirational Layout
    
    
    static let inspirational = UICollectionViewCompositionalLayout { section, environment in
        
        let margin: CGFloat = 10
        
        
        /// OneSingle™
        /// +-------------------+
        /// |                   |
        /// |                   |
        /// |                   |
        /// |                   |
        /// +-------------------+
        let osItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/7)))
        osItem.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: margin, bottom: 0, trailing: margin)
        
        
        /// OneLeftOneRight™
        /// +--------+ +--------+
        /// |        | |        |
        /// |        | |        |
        /// |        | |        |
        /// |        | |        |
        /// +--------+ +--------+
        let olorItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        olorItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: 0)
        
        let olorGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/7)),
            subitems: [olorItem, olorItem]
        )
        olorGroup.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: 0, bottom: 0, trailing: margin)
        
        
        /// OneLeftTwoRight™
        /// +--------+ +---------+
        /// |        | |         |
        /// |        | +---------+
        /// |        | +---------+
        /// |        | |         |
        /// +--------+ +---------+
        let oltrLeftItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
        oltrLeftItem.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: margin, bottom: 0, trailing: 0)
        
        let oltrRightItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
        oltrRightItem.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: margin, bottom: 0, trailing: 0)
        
        let oltrRightGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)),
            subitems: [oltrRightItem, oltrRightItem]
        )
        
        let oltrGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/7)),
            subitems: [oltrLeftItem, oltrRightGroup]
        )
        oltrGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: margin)
        
        
        /// TripleThumb™
        /// +----+ +----+ +----+
        /// |    | |    | |    | 
        /// +----+ +----+ +----+
        let ttItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        ttItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: 0)
        
        let ttGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/7)),
            subitems: [ttItem, ttItem, ttItem]
        )
        ttGroup.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: 0, bottom: 0, trailing: margin)
        
        
        /// Container Group
        let containerGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
            subitems: [osItem, oltrGroup, ttGroup, olorGroup]
        )
        
        return NSCollectionLayoutSection(group: containerGroup)
    }
    
    
    // MARK: Rectangle Layout
    
    
    static let rectangle = UICollectionViewCompositionalLayout { section, environment in
        
        let margin: CGFloat = 10
        
        
        /// OneSingle™
        /// +-------------------+
        /// |                   |
        /// |                   |
        /// |                   |
        /// |                   |
        /// +-------------------+
        let osItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        osItem.contentInsets = NSDirectionalEdgeInsets(top: margin, leading: 0, bottom: 0, trailing: 0)
        
        
        /// Container Group
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/7)),
            subitems: [osItem]
        )
        
        return NSCollectionLayoutSection(group: containerGroup)
    }
}
