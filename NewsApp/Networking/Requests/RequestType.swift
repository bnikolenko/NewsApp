//
//  RequestType.swift
//  NewsApp
//
//  Created by Bodia on 14.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//
import Foundation

let scheme = "http"
let host = "newsapi.org"
let apiKey = "f01212ed32d0495ab3066077bd751012"

enum Method: String {
    case post = "POST"
    case get = "GET"
}

typealias BodyType = [String: Any]
typealias QueryItemsType = [String: String?]

protocol RequestType {
    var endpoint: String { get }
    var method: Method { get }
    var body: BodyType? { get }
    var queryItems: QueryItemsType? { get }
}

extension RequestType {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint
        let items = queryItems?.keys.map({ key -> URLQueryItem in
            return URLQueryItem(name: key, value: queryItems?[key, default: nil])
        })

        components.queryItems = items
        
        guard let url = components.url else { return nil }
        print(url)
        var request = URLRequest(url: url)
        if let body = body,
           let bodyData = try? JSONSerialization
            .data(withJSONObject: body, options: []) {
            request.httpBody = bodyData
        }
        return request
    }
}
