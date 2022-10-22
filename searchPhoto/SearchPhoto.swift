import Foundation

// MARK: - SearchPhoto
struct SearchPhoto: Codable, Hashable {
    let total, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable, Hashable {
    let id: String
    let updatedAt: String
    let resultDescription: String?
    let urls: Urls
    let links: Links
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case resultDescription = "description"
        case urls, links, likes
    }
}

// MARK: - Links
struct Links: Codable, Hashable {
    let html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable, Hashable {
    let thumb: String
}
