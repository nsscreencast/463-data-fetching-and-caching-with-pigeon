//
//  ContentView.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/29/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Planets", destination: PlanetList())
            }
            .navigationTitle("Star Wars Universe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
