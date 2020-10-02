//
//  PlanetResidents.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/29/20.
//

import SwiftUI
import Combine
import Pigeon

struct PlanetResidents: View {
    
    let planet: Planet
    
    @ObservedObject var planetsConsumer = Query<Void, [Planet]>.Consumer(key: QueryKey(value: "planets"))
    
    var otherPlanets: [Planet] {
        (planetsConsumer.state.value ?? []).filter { $0 != planet }
    }
    
    var body: some View {
        
        List {
            Section {
                ForEach(planet.residents, id: \.self) { characterURL in
                    CharacterRow(url: characterURL)
                }
            }
            
            Section(header: Text("Other planets")) {
                ForEach(otherPlanets) { planet in
                    NavigationLink(planet.name, destination: PlanetResidents(planet: planet))
                }
            }
        }
        .navigationTitle("\(planet.name) Residents")
    }
}

struct CharacterRow: View {
    let url: URL
    
    @ObservedObject var query = Query<URL, Character>(
        key: QueryKey(value: "characters"),
        keyAdapter: { key, url in
            key.appending(url.path)
        },
        cacheConfig: .init(invalidationPolicy: .expiresAfter(1000), usagePolicy: .useInsteadOfFetching),
        fetcher: { url in
            print("FETCHING CHARACTER: \(url)")
            return GetCharacterRequest(url: url)
                .execute()
                .eraseToAnyPublisher()
        })
    
    var body: some View {
        Text(query.state.value?.name ?? "...")
            .onAppear() { query.refetch(request: url) }
    }
}
