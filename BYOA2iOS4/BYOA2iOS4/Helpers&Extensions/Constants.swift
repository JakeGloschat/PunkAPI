//
//  Constants.swift
//  BYOA2iOS4
//
//  Created by Jake Gloschat on 3/1/23.
//

import Foundation

struct Constants {
    
    struct BeerList {
        static let beersBaseURL = "https://api.punkapi.com/v2"
        static let allBeersPath = "/beers"
        static let randomBeerPath = "beers/random"
    }
    
    struct Error {
        static let unkownError = "Unknown Error At This Time."
    }
}
