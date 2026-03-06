//
//  Driver.swift
//  DriverID
//
//  Created by Zihong Lin on 3/5/26.
//


import Foundation

struct Driver: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}