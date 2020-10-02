//
//  NetworkDispatcher.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation
import Combine

protocol NetworkDispatcher {
    func dispatch(requestData: RequestData) -> AnyPublisher<Data, Error>
}

class URLSessionDispatcher: NetworkDispatcher {
    static let `default` = URLSessionDispatcher(session: .shared)
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func dispatch(requestData: RequestData) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: requestData.build())
            .map { $0.data }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
