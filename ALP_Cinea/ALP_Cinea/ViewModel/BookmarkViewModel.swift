import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookmarkViewModel: ObservableObject {
    @Published var bookmarkedFilms: [Film] = []

    private let db = Firestore.firestore()

    var userId: String? {
        Auth.auth().currentUser?.uid
    }

    func isBookmarked(_ film: Film) -> Bool {
        bookmarkedFilms.contains(where: { $0.title == film.title })
    }

    func toggleBookmark(for film: Film) {
        if isBookmarked(film) {
            removeBookmark(film)
        } else {
            addBookmark(film)
        }
    }

    func loadBookmarks() {
        guard let userId = userId else { return }

        db.collection("users").document(userId).collection("bookmarks").getDocuments { snapshot, error in
            if let error = error {
                print("Failed to load bookmarks: \(error.localizedDescription)")
                return
            }

            self.bookmarkedFilms = snapshot?.documents.compactMap { doc -> Film? in
                let data = doc.data()
                return Film(
                    title: data["title"] as? String ?? "",
                    genres: data["genres"] as? [String] ?? [],
                    rating: data["rating"] as? Double ?? 0.0,
                    platform: data["platform"] as? String ?? "",
                    duration: data["duration"] as? String ?? "",
                    synopsis: data["synopsis"] as? String ?? "",
                    posterName: data["posterName"] as? String ?? "",
                    reviews: []
                )
            } ?? []
        }
    }

    private func addBookmark(_ film: Film) {
        guard let userId = userId else { return }
        
        if isBookmarked(film) { return }

        let filmData: [String: Any] = [
            "title": film.title,
            "genres": film.genres,
            "rating": film.rating,
            "platform": film.platform,
            "duration": film.duration,
            "synopsis": film.synopsis,
            "posterName": film.posterName
        ]

        db.collection("users").document(userId).collection("bookmarks").document(film.title).setData(filmData) { error in
            if let error = error {
                print("Failed to add bookmark: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.bookmarkedFilms.append(film)
                }
            }
        }
    }
    private func removeBookmark(_ film: Film) {
        guard let userId = userId else { return }

        db.collection("users").document(userId).collection("bookmarks").document(film.title).delete { error in
            if let error = error {
                print("Failed to remove bookmark: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.bookmarkedFilms.removeAll(where: { $0.title == film.title })
                }
            }
        }
    }
}
