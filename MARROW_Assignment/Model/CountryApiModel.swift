import Foundation

struct ResponseModel: Codable {
    let data: [String: Country]
}

struct Country: Codable {
    let country: String
    let region: String
}

enum Region: Codable {
    case africa
    case antarctic
    case asia
    case centralAmerica
}

struct DefaultCountry: Codable {
    let country: String
}
