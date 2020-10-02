//
//  PlanetList.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/29/20.
//

import SwiftUI
import Combine
import Pigeon

struct PlanetList: View {
    
    @ObservedObject var query = Query<Void, [Planet]>(
        key: QueryKey(value: "planets"),
        behavior: .startImmediately(()),        
        cacheConfig: QueryCacheConfig(invalidationPolicy: .expiresAfter(1000), usagePolicy: .useInsteadOfFetching),
        fetcher: {
            print("FETCHING PLANETS")
            return GetPlanetsRequest()
                .execute()
                .map { $0.results }
                .eraseToAnyPublisher()
        }
    )
    
    
    var body: some View {
        view(for: query.state)
            .navigationTitle("Planets")
    }
}

extension PlanetList: QueryRenderer {
    var loadingView: some View {
        Text("Loading...")
    }
    
    func successView(for planets: [Planet]) -> some View {
        List(planets) { planet in
            NavigationLink(planet.name, destination: PlanetResidents(planet: planet))
        }
    }
    
    func failureView(for failure: Error) -> some View {
        Text("Error loading planets: \(failure.localizedDescription)")
            .foregroundColor(.red)
    }
}

struct PlanetList_Previews: PreviewProvider {
    static var previews: some View {
        PlanetList()
    }
}
