import Foundation

struct TMDbResponse: Codable {
    let results: [TMDbMovie]
}

struct TMDbMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
    let genre_ids: [Int]
}
