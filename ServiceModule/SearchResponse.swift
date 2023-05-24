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
    
    let keyword: String
    let pagesCount: Int
    let searchFilmsCountResult: Int
    let films: [Film]
}
