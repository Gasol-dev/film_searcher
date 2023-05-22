//
//  SearchResponse.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Foundation

// MARK: - SearchResponse

struct SearchResponse: Decodable {
    
    // MARK: - Properties
    
    let pagesCount: Int
    let films: [String]
}
