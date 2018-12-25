//
//  jsonData.swift
//  StudioFinder
//
//  Created by Admin on 04.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct PlaceData: Decodable {
    let created: String
    let count, offset: Int
    let places: [Place]
}

struct Place: Decodable {
    let id: String
    let type: String?
    let typeID: String?
    let score: Int
    let name: String
    let lifeSpan: PlaceLifeSpan
    let address: String?
    let area: Area?
    let disambiguation: String?
    let coordinates: Coordinates?
    let aliases: [Alias]?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case typeID = "type-id"
        case score, name
        case lifeSpan = "life-span"
        case address, area, disambiguation, coordinates, aliases
    }
}

struct Alias: Decodable {
    let sortName: String
    let typeID: String?
    let name: String
    let locale: String?
    let type: String?
    let primary: Bool?
    let beginDate, endDate: String?
    
    enum CodingKeys: String, CodingKey {
        case sortName = "sort-name"
        case typeID = "type-id"
        case name, locale, type, primary
        case beginDate = "begin-date"
        case endDate = "end-date"
    }
}

struct Area: Decodable {
    let id: String
    let type: String?
    let typeID, name, sortName: String
    let lifeSpan: AreaLifeSpan
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case typeID = "type-id"
        case name
        case sortName = "sort-name"
        case lifeSpan = "life-span"
    }
}

struct AreaLifeSpan: Decodable {
    let ended: Bool?
}

struct Coordinates: Decodable {
    let latitude, longitude: String
}

struct PlaceLifeSpan: Decodable {
    let ended: Bool?
    let begin, end: String?
}
