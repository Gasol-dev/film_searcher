//
//  SearchErrorStatus.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 23.05.2023.
//

import Foundation

// MARK: - SearchStatusCode

enum SearchStatusCode: Int {
    
    // MARK: - Cases
    
    case success = 200
    case wrongToken = 401
    case requestLimitExceeded = 402
    case filmsNotFound = 404
    case tooManyRequests = 429
    
    // MARK: - Properties
    
    var description: String {
        switch self {
        case .success:
            return "Успешно"
        case .wrongToken:
            return "Пустой или неправильный токен"
        case .requestLimitExceeded:
            return "Превышен лимит запросов(или дневной, или общий)"
        case .filmsNotFound:
            return "Фильмы не найдены"
        case .tooManyRequests:
            return "Слишком много запросов. Лимит 5 запросов в секунду"
        }
    }
}
