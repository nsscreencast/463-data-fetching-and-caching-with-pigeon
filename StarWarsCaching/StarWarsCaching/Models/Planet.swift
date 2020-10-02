//
//  Planet.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation

struct Planet: Codable, Identifiable, Equatable, Hashable {
    var id: String { name }
    let name: String
    let terrain: String
    let population: String
    let residents: [URL]
}
