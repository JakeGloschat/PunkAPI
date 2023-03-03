//
//  Beer.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct Beer: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case tagline
        case description
        case image = "image_url"
        case abv
        case ibu
        case volume
    }
    
    let name: String
    let tagline: String
    let description: String
    let image: String?
    let abv: Double
    let ibu: Double?
    let volume: Volume
}

struct Volume: Decodable {
    
    let value: Int
    let unit: String
    
}
