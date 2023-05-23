//
//  MainAction.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReSwift

// MARK: - SearchResultAction

struct SearchResultAction: Action {
    
    /// Search result
    let result: [String]
}

// MARK: - SearchAction

struct SearchAction: Action {
    
    // MARK: - Properties
    
    /// Target search name
    let targetName: String
}

// MARK: - ResetSearchAction

struct ResetSearchAction: Action {}
