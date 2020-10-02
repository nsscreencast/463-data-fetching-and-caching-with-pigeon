//
//  GetPlanetsRequest.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation

struct GetPlanetsRequest: Request {
    struct PlanetResponse: Codable {
        let results: [Planet]
    }
    
    typealias ResponseType = PlanetResponse
    
    var requestData: RequestData {
        RequestData(.get, path: "planets", baseURL: StarWarsAPI.baseURL)
    }
}

