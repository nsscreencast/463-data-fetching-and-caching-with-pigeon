//
//  Networking.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation
import Combine

enum ConnectionError: Swift.Error {
    case invalidURL
    case noData
}

enum HTTPMethod: String {
    case get = "GET"
}

struct RequestData {
    let baseURL: URL
    let method: HTTPMethod
    let path: String
    let params: [String: Any]?
    let headers: [String: String]?
    
    init(_ method: HTTPMethod, path: String, baseURL: URL, params: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.baseURL = baseURL
        self.params = params
        self.headers = headers
    }
    
    func build() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        
        return request
    }
}

protocol Request {
    associatedtype ResponseType: Codable
    var requestData: RequestData { get }
    var decoder: JSONDecoder? { get }
}

extension Request {
    var decoder: JSONDecoder? { nil }
    
    func execute(dispatcher: NetworkDispatcher = URLSessionDispatcher.default) -> AnyPublisher<ResponseType, Error> {
        dispatcher.dispatch(requestData: requestData)
            .decode(type: ResponseType.self, decoder: decoder ?? JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
