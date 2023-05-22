//
//  MainStore.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReSwift

// MARK: - MainStore

let mainStore = Store<MainState>(reducer: mainReducer, state: nil)
