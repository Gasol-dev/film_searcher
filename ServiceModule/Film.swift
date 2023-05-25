//
//  Film.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 24.05.2023.
//

import Foundation

// MARK: - Film

public struct Film: Decodable {
    
    // MARK: - Properties
    
    private var nameRu: String?
    
    private var nameEn: String?
    
    public var posterUrlPreview: String
    
    public var posterUrl: String?
    
    public var name: String {
        nameRu ?? nameEn ?? ""
    }
}
