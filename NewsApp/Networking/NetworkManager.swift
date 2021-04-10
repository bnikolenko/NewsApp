//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Bodia on 14.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import Foundation

enum GenericError: Error {
    case genericError
}

class NetworkManager {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func fetch<T: Codable>(request: RequestType,
                           completion: @escaping (Swift.Result<T, Error>) -> Void) {
        guard let request = request.urlRequest else { return }
        print("didCall fetch")
        dataTask?.cancel()
        dataTask = defaultSession
            .dataTask(with: request) { (data, _, error) in
                print("task did finish")
                if let error = error { completion(.failure(error)) }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Formatter.iso8601Formatter)
                if let data = data, let resultType = try? decoder.decode(T.self, from: data) {
                    print("willCall Completion")
                    completion(.success(resultType))
                } else {
                    completion(.failure(GenericError.genericError))
                }
            }
        print("willResume task")
        dataTask?.resume()
    }
}

enum NetworkResponse: String {
    case success
    case fail = "Request failed"
    case badRequest = "Bad request"
}

enum Result<String> {
    case success
    case failure(String)
}

func handleResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299: return .success
    case 401...599: return .failure(NetworkResponse.badRequest.rawValue)
    default: return .failure(NetworkResponse.fail.rawValue)
    }
}
