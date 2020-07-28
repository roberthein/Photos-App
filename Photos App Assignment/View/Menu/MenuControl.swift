//
//  MenuControl.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 27/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


protocol MenuControlDelegate: AnyObject {
    func didSelect<T: MenuType>(control: MenuControl<T>)
}


// MARK: - Menu Control


class MenuControl<T: MenuType>: UIView, UIGestureRecognizerDelegate {
    
    weak var delegate: MenuControlDelegate?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.Color.disabled.withAlphaComponent(0.2)
        view.layer.cornerRadius = 7
        view.isHidden = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Theme.Color.tint
        view.textAlignment = .center
        view.text = type.title
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: type.icon)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.tintColor = Theme.Color.tint
        
        return view
    }()
    
    let type: T
    
    
    // MARK: Initialization
    

    required init(type: T) {
        self.type = type
        super.init(frame: .zero)
        
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(titleLabel)
        
        let backgroundMargin: CGFloat = 10
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -backgroundMargin),
            backgroundView.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: backgroundMargin),
            backgroundView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        imageView.isHidden = type.icon == nil
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        updateStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: State
    
    
    var isSelected: Bool = false {
        didSet {
            guard isSelected != oldValue else { return }
            
            
            backgroundView.isHidden = !isSelected
            updateStyle()
            
            if isSelected {
                bounce()
                delegate?.didSelect(control: self)
            }
        }
    }
    
    
    // MARK: Update
    
    
    private func updateStyle() {
        guard isSelected else {
            imageView.image = type.icon
            imageView.tintColor = Theme.Color.disabled
            titleLabel.textColor = Theme.Color.disabled
            titleLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight.bold)
            return
        }
        
        imageView.image = type.iconSelected
        imageView.tintColor = Theme.Color.tint
        titleLabel.textColor = Theme.Color.tint
        titleLabel.font = .systemFont(ofSize: 14, weight: UIFont.Weight.black)
    }
    
    
    // MARK: Gestures
    
    
    @objc func tap(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if case .ended = gestureRecognizer.state {
            isSelected = true
        }
    }
}
