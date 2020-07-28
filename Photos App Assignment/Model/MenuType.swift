//
//  MenuType.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 26/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Menu Type


protocol MenuType: CaseIterable, Equatable {
    var title: String? { get }
    var icon: UIImage? { get }
    var iconSelected: UIImage? { get }
}
