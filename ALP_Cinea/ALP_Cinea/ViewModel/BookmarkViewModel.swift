import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var bookmarkedFilms: [Film] = []

    func isBookmarked(_ film: Film) -> Bool {
        bookmarkedFilms.contains(where: { $0.title == film.title })
    }

    func toggleBookmark(for film: Film) {
        if isBookmarked(film) {
            bookmarkedFilms.removeAll(where: { $0.title == film.title })
        } else {
            bookmarkedFilms.append(film)
        }
    }
}
