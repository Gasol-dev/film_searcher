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
        container.register(MainViewController.self) { _ in
            MainViewController()
        }
        container.register(ServiceProtocol.self) { r in
            Service(session: URLSession(configuration: .default))
        }
        return container
    }()
}
