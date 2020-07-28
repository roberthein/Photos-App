//
//  NetworkError.swift
//  Photos App Assignment
//
//  Created by Robert-Hein Hooijmans on 24/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation


// MARK: - NetworkError


public enum NetworkError: Error {
    case unknown
    case statusCode(Int)
    case noData
    case notImageData
}
