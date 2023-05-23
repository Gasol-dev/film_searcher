//
//  MainReducer.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReSwift
import ServiceModule
import ReactiveKit

// MARK: - MainReducer

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState(filmModels: [])
    switch action {
    case let action as SearchAction:
        let container = DependenciesContainer.default.container
        let service = container.resolve(ServiceProtocol.self)
        let _ = service?
            .searchFilms(with: APIConstants.token, name: action.targetName)
            .subscribe(on: ExecutionContext.global(qos: .userInitiated))
            .receive(on: ExecutionContext.main)
            .observeNext { names in
                mainStore.dispatch(SearchResultAction(result: names))
            }
    case let action as SearchResultAction:
        state.filmModels = action.result.map { FilmCellViewModel(filmName: $0) }
    case _ as ResetSearchAction:
        state.filmModels = []
    default:
        break
    }
    return state
}
