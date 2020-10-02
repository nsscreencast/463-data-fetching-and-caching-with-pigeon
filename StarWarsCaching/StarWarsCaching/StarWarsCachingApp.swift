//
//  StarWarsCachingApp.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/29/20.
//

import SwiftUI
import Pigeon

@main
struct StarWarsCachingApp: App {
    
    init() {
        QueryCache.setGlobal(.userDefaults)        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
