//
//  PhotoViewCell.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Photo View Cell


class PhotoViewCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            imageView.image = photo?.image
        }
    }
    
    private lazy var placeholderImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "photo", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)))
        view.tintColor = Theme.Color.backgroundSecondary
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    
    // MARK: Initialization
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        
        contentView.addSubview(placeholderImageView)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Layout
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderImageView.frame = contentView.frame
        imageView.frame = contentView.frame
    }
}
