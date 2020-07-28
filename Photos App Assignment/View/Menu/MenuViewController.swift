//
//  MenuViewController.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Menu View Controller Delegate


protocol MenuViewControllerDelegate: AnyObject {
    func didSelect<T: MenuType>(menuType: T)
}


// MARK: - Menu View Controller


class MenuViewController<T: MenuType>: UIViewController, MenuControlDelegate {
    
    weak var delegate: MenuViewControllerDelegate?
    
    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemMaterial)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var menuStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: T.allCases.map { MenuControl(type: $0) })
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fillEqually
        
        return view
    }()
    
    
    // MARK: View lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = nil
        view.isOpaque = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderColor = Theme.Color.disabled.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 1 / UIScreen.main.scale
        
        view.addSubview(blurView)
        blurView.contentView.addSubview(menuStackView)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5),
            
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            menuStackView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor),
            menuStackView.leftAnchor.constraint(equalTo: blurView.contentView.leftAnchor, constant: 20),
            menuStackView.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor),
            menuStackView.rightAnchor.constraint(equalTo: blurView.contentView.rightAnchor, constant: -20),
        ])
        
        menuStackView.arrangedSubviews
            .compactMap { $0 as? MenuControl<T> }
            .forEach { $0.delegate = self }
        
        menuStackView.arrangedSubviews
            .compactMap { $0 as? MenuControl<T> }
            .first?.isSelected = true
    }
    
    
    // MARK: Actions
    
    
    private func update<T: MenuType>(selected: MenuControl<T>) {
        menuStackView.arrangedSubviews
            .compactMap { $0 as? MenuControl<T> }
            .filter { $0 != selected }
            .forEach { $0.isSelected = false }
    }
    
    
    // MARK: Menu Control Delegate
    
    
    func didSelect<T: MenuType>(control: MenuControl<T>) {
        delegate?.didSelect(menuType: control.type)
        update(selected: control)
    }
}
