//
//  BookmarkViewModel_MAC.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class BookmarkViewModel_MAC: ObservableObject {
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

            guard let documents = snapshot?.documents else {
                self.bookmarkedFilms = []
                return
            }

            var loadedFilms: [Film] = []

            for doc in documents {
                let data = doc.data()
                
                let title = data["title"] as? String ?? ""
                let genres = data["genres"] as? [String] ?? []
                let rating = data["rating"] as? Double ?? 0.0
                let platform = data["platform"] as? String ?? ""
                let duration = data["duration"] as? String ?? ""
                let synopsis = data["synopsis"] as? String ?? ""
                let posterName = data["posterName"] as? String ?? ""

                let film = Film(
                    title: title,
                    genres: genres,
                    rating: rating,
                    platform: platform,
                    duration: duration,
                    synopsis: synopsis,
                    posterName: posterName,
                    reviews: []
                )
                loadedFilms.append(film)
            }

            DispatchQueue.main.async {
                self.bookmarkedFilms = loadedFilms
            }
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
