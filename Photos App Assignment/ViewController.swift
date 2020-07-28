//
//  ViewController.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit


// MARK: - Container View Controller


class ViewController: UIViewController {
    
    private lazy var photoViewController = PhotoViewController(collectionViewLayout: .inspirational)
    private lazy var layoutMenuController = MenuViewController<LayoutType>()
    private lazy var locationMenuController = MenuViewController<LocationType>()
    private lazy var gradientView = GradientView()
    
    // MARK: View lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insetsLayoutMarginsFromSafeArea = false
        
        add(photoViewController)
        photoViewController.view.addSubview(gradientView)
        add(layoutMenuController)
        add(locationMenuController)
        
        layoutMenuController.delegate = self
        locationMenuController.delegate = self
        
        NSLayoutConstraint.activate([
            photoViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            photoViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            photoViewController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            photoViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            gradientView.heightAnchor.constraint(equalTo: photoViewController.view.heightAnchor, multiplier: 1/3),
            gradientView.leftAnchor.constraint(equalTo: photoViewController.view.leftAnchor),
            gradientView.bottomAnchor.constraint(equalTo: photoViewController.view.bottomAnchor),
            gradientView.rightAnchor.constraint(equalTo: photoViewController.view.rightAnchor),
            
            layoutMenuController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            layoutMenuController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            layoutMenuController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            locationMenuController.view.widthAnchor.constraint(equalTo: layoutMenuController.view.widthAnchor, multiplier: 3/4),
            locationMenuController.view.bottomAnchor.constraint(equalTo: layoutMenuController.view.topAnchor, constant: -10),
            locationMenuController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
        ])
    }
    
    private func add(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.didMove(toParent: self)
    }
}


// MARK: - Menu View Controller Delegate


extension ViewController: MenuViewControllerDelegate {
    
    func didSelect<T: MenuType>(menuType: T) {
        if let layout = menuType as? LayoutType {
            photoViewController.collectionView.setCollectionViewLayout(layout.createCollectionViewLayout(), animated: true)
        } else if let location = menuType as? LocationType {
            photoViewController.location = location
        }
    }
}
