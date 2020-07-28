//
//  Extensions.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 25/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


// MARK: - Collection Reusable View


extension UICollectionReusableView {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}


// MARK: - Animations


extension UIView.AnimationOptions {
    
    static var interactiveAnimation: UIView.AnimationOptions {
        [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction]
    }
}

extension UIView {
    
    func bounce() {
        transform = CGAffineTransform(scaleX: 0.995, y: 0.995)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 500, options: .interactiveAnimation, animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
