import Foundation

struct Film: Identifiable {
    let id = UUID()
    let title: String
    let genres: [String]
    let rating: Double
    let platform: String
    let duration: String
    let synopsis: String
    let posterName: String
    let reviews: [Review]
}
