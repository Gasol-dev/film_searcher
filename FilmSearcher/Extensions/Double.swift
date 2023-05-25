//
//  Double.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 25.05.2023.
//

import Foundation

// MARK: - Double

extension Double {

    static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        .random(in: lower...upper)
    }
}
