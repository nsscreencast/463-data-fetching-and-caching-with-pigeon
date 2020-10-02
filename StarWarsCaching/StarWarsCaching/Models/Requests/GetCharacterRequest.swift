//
//  GetCharacterRequest.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation

struct GetCharacterRequest: Request {
    typealias ResponseType = Character
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var requestData: RequestData {
        RequestData(.get, path: "", baseURL: url)
    }
}

