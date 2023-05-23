//
//  ServiceModule.swift
//  ServiceModule
//
//  Created by Alexander Lezya on 22.05.2023.
//

import ReactiveKit

// MARK: - Service

final public class Service {
    
    // MARK: - Properties
    
    private let defaultSession: URLSession
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameter session: URLSession instance
    public init(session: URLSession) {
        self.defaultSession = session
    }
}

// MARK: - ServiceProtocol

extension Service: ServiceProtocol {

    public func searchFilms(with token: String, name: String) -> Signal<[String], Error> {
        Signal { observer in
            guard
                var urlComponents = URLComponents(string: "https://kinopoiskapiunofficial.tech/api/v2.1/search-by-keyword") else {
                return BlockDisposable {
                    print("URL Components is nil")
                }
            }
            urlComponents.queryItems = [URLQueryItem(name: "keyword", value: name)]
            guard let url = urlComponents.url else {
                return BlockDisposable {
                    print("URL is nil")
                }
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(token, forHTTPHeaderField: "X-API-KEY")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = self.defaultSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.receive(completion: .failure(error))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == SearchStatusCode.success.rawValue {
                    guard let responseObject = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                        print("Decoding error")
                        return
                    }
                    observer.receive(responseObject.films)
                    observer.receive(completion: .finished)
                } else if let _ = data, // remove
                          let response = response as? HTTPURLResponse {
                    observer.receive(
                        SearchStatusCode(rawValue: response.statusCode)?
                            .description
                            .components(separatedBy: " ") ?? []
                    )
                    observer.receive(completion: .finished)
                }
            }
            dataTask.resume()
            return BlockDisposable {
                dataTask.cancel()
            }
        }
    }
}
