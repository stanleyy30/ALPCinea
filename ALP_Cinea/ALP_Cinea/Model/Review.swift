import Foundation

struct Review: Identifiable {
    let id = UUID()
    let username: String
    let comment: String
}
