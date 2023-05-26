//
//  MainAction.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReSwift

// MARK: - MainAction

struct MainAction: Action {}

// MARK: - ShareButtonTapAction

struct ShareButtonTapAction: Action {
    
    let url: URL
}

// MARK: - ResetShareURLTapAction

struct ResetShareURLTapAction: Action {}
