//
//  MainState.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Foundation

// MARK: - MainState

struct MainState {
    
    // MARK: - Properties
    
    var token = APIConstants.token
    var filmModels: [FilmCellViewModelProtocol] = []
}
