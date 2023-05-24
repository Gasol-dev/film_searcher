//
//  FilmCellViewModelProtocol.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Foundation

// MARK: - FilmCellViewModelProtocol

protocol FilmCellViewModelProtocol {
    
    /// Film name
    var filmName: String { get }
    
    /// Film image URL
    var imageURL: URL? { get }
}
