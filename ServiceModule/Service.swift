//
//  ServiceModule.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 22.05.2023.
//

import Alamofire
import ReactiveKit

// MARK: - Service

final class Service {
    
    // MARK: - Properties
    
    private let defaultSession: URLSession
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameter session: URLSession instance
    init(session: URLSession) {
        self.defaultSession = session
    }
}

// MARK: - ServiceProtocol

extension Service: ServiceProtocol {

    func searchFilms(with token: String, name: String) -> Signal<[Film], Error> {
        Signal { observer in
            guard let url = URL(string: Constants.searchFilmURL) else {
                return BlockDisposable { print("URL is nil") }
            }
            let request = AF.request(
                url,
                parameters: ["keyword": name],
                headers: [
                    "X-API-KEY": token,
                    "Content-Type": "application/json"
                ]
            ).responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let responseObject):
                    guard let statusCode = response.response?.statusCode,
                          let searchStatusCode = SearchStatusCode(rawValue: statusCode) else {
                        return
                    }
                    switch searchStatusCode {
                    case .success:
                        observer.receive(responseObject.films)
                        observer.receive(completion: .finished)
                    case .filmsNotFound, .requestLimitExceeded, .wrongToken, .tooManyRequests:
                        print(searchStatusCode.description)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return BlockDisposable {
                request.cancel()
            }
        }
    }
}

extension Service {
    
    enum Constants {
        static let searchFilmURL = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword"
    }
}
