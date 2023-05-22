//
//  FilmModel.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Foundation

// MARK: - FilmCellViewModel

struct FilmCellViewModel: FilmCellViewModelProtocol {
    
    // MARK: - Properties
    
    /// Film name
    let filmName: String
    
    /// Default initializer
    /// - Parameter filmName: current film name
    init(filmName: String) {
        self.filmName = filmName
    }
}
