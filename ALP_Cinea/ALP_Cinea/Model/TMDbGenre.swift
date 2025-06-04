import Foundation

struct TMDbGenreResponse: Codable {
    let genres: [TMDbGenre]
}

struct TMDbGenre: Codable {
    let id: Int
    let name: String
}
