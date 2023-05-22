//
//  ServiceProtocol.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReactiveKit

// MARK: - ServiceProtocol

public protocol ServiceProtocol {
    
    func searchFilms(with token: String, name: String) -> Signal<[String], Error>
}
