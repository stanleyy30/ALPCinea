import SwiftUI

struct HomeTabView: View {
    @StateObject private var filmViewModel = FilmViewModel()

    var body: some View {
        GeometryReader { geometry in
            TabView {
                MainView(viewModel: filmViewModel)
                    .frame(maxWidth: geometry.size.width > 800 ? 700 : .infinity) 
                    .tabItem {
                        Label("Beranda", systemImage: "house.fill")
                    }

                UpcomingView(viewModel: filmViewModel)
                    .frame(maxWidth: geometry.size.width > 800 ? 700 : .infinity)
                    .tabItem {
                        Label("Coming Soon", systemImage: "clock.fill")
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accentColor(.red)
            .onAppear {
                setupTabBarAppearance()
            }
            .background(Color.black.ignoresSafeArea())
        }
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.9)

        appearance.selectionIndicatorTintColor = UIColor.systemRed
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemRed
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemRed,
            .font: UIFont.systemFont(ofSize: 12, weight: .semibold)
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ]

        appearance.shadowColor = UIColor.clear

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    HomeTabView()
}
