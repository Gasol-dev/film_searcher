//
//  ServiceModuleContainer.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 25.05.2023.
//

import Swinject

// MARK: - ServiceModuleContainer

final public class ServiceModuleContainer {
    
    // MARK: - Properties
    
    public static let `default` = ServiceModuleContainer()
    
    public let container: Container = {
        let container = Container()
        container.register(ServiceProtocol.self) { r in
            Service(session: URLSession(configuration: .default))
        }
        return container
    }()
}
