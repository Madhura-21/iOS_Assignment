import Foundation

struct BooksResponseModel: Codable, Hashable {
    let docs: [Books]
}

struct Books: Codable, Hashable {
    let title: String?
    let ratings_average: Double?
    let ratings_count: Int?
    let author_name: [String]?
    let cover_i: Int?
}
