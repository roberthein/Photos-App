//
//  GradientView.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 28/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Gradient View


class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    var gradient: CAGradientLayer? {
        layer as? CAGradientLayer
    }
    
    var colors: [CGColor] {
        [Theme.Color.backgroundPrimary.withAlphaComponent(0).cgColor, Theme.Color.backgroundPrimary.withAlphaComponent(0.6).cgColor]
    }
    
    
    // MARK: Initialization
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        gradient?.locations = [0, 1]
        gradient?.colors = colors
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        gradient?.colors = colors
    }
}
