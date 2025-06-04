import Foundation
import FirebaseFirestore

struct Bookmark: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var movieId: String
    var timestamp: Date
}
