import SwiftUI
import Firebase

@main
struct ALP_CineaApp: App {
    @StateObject var viewModel = FilmViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
