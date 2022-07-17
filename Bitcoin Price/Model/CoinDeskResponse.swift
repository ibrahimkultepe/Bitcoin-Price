//
//  CoinDeskResponse.swift
//  Bitcoin Price
//
//  Created by İbrahim Kültepe on 13.07.2022.
//

import Foundation

struct CoinDeskResponse: Codable {
    let bpi: BPI
}

struct BPI: Codable {
    let usd: Details
    let gbp: Details
    let eur: Details
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct Details: Codable {
    var code: String?
    var rate: String?
}

