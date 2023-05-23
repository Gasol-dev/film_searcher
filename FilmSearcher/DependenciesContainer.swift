//
//  DependenciesContainer.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Swinject
import ServiceModule

// MARK: - DependenciesContainer

final class DependenciesContainer {
    
    // MARK: - Properties
    
    static let `default` = DependenciesContainer()
    
    let container: Container = {
        let container = Container()
        container.register(ServiceProtocol.self) { r in
            Service(session: URLSession(configuration: .default))
        }
        container.register(MainViewController.self) { resolver in
            let searchService = resolver.resolve(ServiceProtocol.self).unsafelyUnwrapped
            return MainViewController(filmModels: [], searchService: searchService)
        }
        return container
    }()
}
