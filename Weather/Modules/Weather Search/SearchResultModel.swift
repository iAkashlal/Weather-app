//
//  SearchResultModel.swift
//  Weather
//
//  Created by akashial on 13/03/22.
//

import Foundation

struct SearchResultModel: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}
