// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum NetworkError: Error {
    case badRequest
    case decodingError
}

public class NetworkService {
   public func fetch<T: Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.decodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
        }.resume()
    }
}
