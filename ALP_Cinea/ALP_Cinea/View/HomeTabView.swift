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
        .accentColor(.red)
        .onAppear {
            setupTabBarAppearance()
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
