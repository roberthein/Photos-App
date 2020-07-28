//
//  PhotoViewController.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Collection View Controller


class PhotoViewController: UICollectionViewController {
    
    private(set) lazy var viewModel = PhotoViewModel()
    
    var location: LocationType = .amsterdam {
        didSet {
            reset()
            viewModel.loadData(for: location)
        }
    }
    
    
    // MARK: View lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isPrefetchingEnabled = true
        collectionView.prefetchDataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = Theme.Color.backgroundPrimary
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.reuseIdentifier)
        
        viewModel.dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) { [weak self] collectionView, indexPath, photo -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.reuseIdentifier, for: indexPath)
            
            self?.viewModel.loadImage(for: photo)
            (cell as? PhotoViewCell)?.photo = photo
            
            return cell
        }
        
        viewModel.loadData(for: location)
    }
    
    
    // MARK: Scroll View Delegate
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.verticalScrollIndicatorInsets.top = abs(min(-1, view.safeAreaInsets.top + scrollView.contentOffset.y))
        
        let bottomPosition = scrollView.bounds.maxY
        let totalHeight = scrollView.contentSize.height
        let maxDistanceFromBottom = scrollView.bounds.height * 6
        let shouldLoadMore = bottomPosition > totalHeight - maxDistanceFromBottom
        
        guard viewModel.state != .isLoading, shouldLoadMore else { return }
        viewModel.loadData(for: location)
    }
    
    
    // MARK: Reset
    
    
    private func reset() {
        Images.reset()
        Network.invalidateAndCancel()
        
        viewModel.pageIndex = 0
        viewModel.state = .idle
        
        var snapshot = viewModel.dataSource.snapshot()
        snapshot.deleteAllItems()
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.dataSource.apply(snapshot, animatingDifferences: false)
        }
        
        collectionView.contentOffset = .zero
    }
}


// MARK: - Data Source Prefetching


extension PhotoViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            viewModel.prefetchImage(at: indexPath)
        }
    }
}
