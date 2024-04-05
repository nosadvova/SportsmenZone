//
//  NetworkService.swift
//  SportsmenZone
//
//  Created by Vova Novosad on 29.03.2024.
//

import Foundation

class NetworkService: CoreNetwork {
    func sendRequest<T>(urlStr: String) async throws -> T where T : Decodable {
            guard let urlStr = urlStr as String?, let url = URL(string: urlStr) as URL? else {
                throw NetworkError.invalidURL
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                throw NetworkError.unexpectedStatusCode
            }
            guard let data = data as Data? else {
                throw NetworkError.unknown
            }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkError.decode
            }
            return decodedResponse
        }
    
    func sendRequest<T: Decodable>(route: ServerRoute) async throws -> T {
        guard let urlRequest = createRequest(route: route) else {
            throw NetworkError.decode
        }
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
                .dataTask(with: urlRequest) { data, response, _ in
                    guard response is HTTPURLResponse else {
                        continuation.resume(throwing: NetworkError.invalidURL)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                        continuation.resume(throwing: NetworkError.unexpectedStatusCode)
                        return
                    }
                    guard let data = data else {
                        continuation.resume(throwing: NetworkError.unknown)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        continuation.resume(throwing: NetworkError.decode)
                        return
                    }
                    continuation.resume(returning: decodedResponse)
                }
            task.resume()
        }
    }
}
