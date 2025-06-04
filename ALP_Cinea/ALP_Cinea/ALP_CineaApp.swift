import SwiftUI
import Firebase

@main
struct ALP_CineaApp: App {
    @StateObject var filmViewModel = FilmViewModel()
    @StateObject var bookmarkViewModel = BookmarkViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(filmViewModel)
                .environmentObject(bookmarkViewModel)
        }
    }
}
