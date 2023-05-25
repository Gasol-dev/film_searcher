//
//  MainReducer.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReSwift

// MARK: - MainReducer

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()
    switch action {
    case let action as ShareButtonTapAction:
        state.shareURL = action.url
    case _ as ResetShareURLTapAction:
        state.shareURL = nil
    default:
        break
    }
    return state
}
