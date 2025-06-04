import SwiftUI

struct HomeTabView: View {
    @StateObject private var filmViewModel = FilmViewModel()

    var body: some View {
        TabView {
            MainView(viewModel: filmViewModel)
                .tabItem {
                    Label("Beranda", systemImage: "house.fill")
                }

            UpcomingView(viewModel: filmViewModel)
                .tabItem {
                    Label("Coming Soon", systemImage: "clock.fill")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    HomeTabView()
}
