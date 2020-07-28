//
//  PhotoViewModel.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit

enum ViewState {
    case idle
    case isLoading
}

enum Section: Int, CaseIterable {
    case main
}


// MARK: - Photo View Model


class PhotoViewModel {
    
    var pageIndex: Int = 0
    var state: ViewState = .idle
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    
    
    // MARK: Load Data
    
    
    func loadData(for location: LocationType) {
        guard state != .isLoading else { return }
        
        pageIndex += 1
        
        state = .isLoading
        
        Network.load(.photos(for: location, page: pageIndex)) { [weak self] result in
            guard let _self = self else { return }
            _self.state = .idle
            
            switch result {
            case .success(let response):
                var snapshot = _self.dataSource.snapshot()
                
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([.main])
                }
                snapshot.appendItems(response.photos)
                
                DispatchQueue.global(qos: .background).async {
                    _self.dataSource.apply(snapshot, animatingDifferences: false)
                }
            default: break
            }
        }
    }
    
    
    // MARK: Prefetch Image
    
    
    func prefetchImage(at indexPath: IndexPath) {
        guard let photo = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        Images.prefetchImage(for: photo)
    }
    
    
    // MARK: Load Image
    
    
    func loadImage(for photo: Photo) {
        
        Images.loadImage(for: photo) { [weak self] photo, image in
            guard let _self = self else { return }
            guard let image = image, image != photo.image else { return }
            
            photo.image = image
            
            var snapshot = _self.dataSource.snapshot()
            guard snapshot.indexOfItem(photo) != nil else { return }
            
            snapshot.reloadItems([photo])
            
            DispatchQueue.global(qos: .background).async {
                _self.dataSource.apply(snapshot, animatingDifferences: false)
            }
        }
    }
}
