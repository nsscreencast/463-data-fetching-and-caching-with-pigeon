//
//  Person.swift
//  StarWarsCaching
//
//  Created by Ben Scheirman on 9/28/20.
//

import Foundation

struct Character:  Codable, Identifiable {
    var id: String { name }
    let name: String
}
