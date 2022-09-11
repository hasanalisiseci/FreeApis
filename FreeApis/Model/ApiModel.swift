//
//  ApiModel.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import Foundation

// MARK: - FreeApis

struct FreeApiModel: Codable {
    let count: Int
    let entries: [Entry]
}

// MARK: - Entry

struct Entry: Codable, Hashable {
    let api, entryDescription: String
    let auth: Auth
    let https: Bool
    let cors: Cors
    let link: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case api = "API"
        case entryDescription = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}

enum Auth: String, Codable {
    case apiKey
    case empty = ""
    case oAuth = "OAuth"
    case userAgent = "User-Agent"
    case xMashapeKey = "X-Mashape-Key"
}

enum Cors: String, Codable {
    case no
    case unknown
    case unkown
    case yes

    enum CodingKeys: String, CodingKey {
        case unkown = "unknown"
    }
}

extension Entry {
    static let dummyEntry = Entry(api: "Biriyani As A Service", entryDescription: "Provides detailed character and guild rankings for Raiding and Mythic+ content in World of Warcraft", auth: Auth.empty, https: true, cors: Cors.unknown, link: "https://raider.io/api", category: "Cloud Storage & File Sharing")
}
