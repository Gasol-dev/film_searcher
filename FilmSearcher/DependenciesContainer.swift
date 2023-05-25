//
//  DependenciesContainer.swift
//  FilmSearcher
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Swinject
import ServiceModule
import SwinjectAutoregistration

// MARK: - DependenciesContainer

final class DependenciesContainer {
    
    // MARK: - Properties
    
    static let `default` = DependenciesContainer()
    
    let container: Container = {
        let container = Container(parent: ServiceModuleContainer.default.container)
        container.register(MainViewController.self) { r in
            MainViewController(filmModels: [], searchService: r~>)
        }
        return container
    }()
}
