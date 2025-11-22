//
//  CharactersResponse.swift
//  CMC-UMC-R
//
//  Created by Subeen on 11/23/25.
//

struct CharactersResponse: Codable {
    let level: Int
    let imageURL: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case level
        case imageURL = "imageUrl"
        case count
    }
}
