//
//  HomeTabView.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

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
            .background(Color.black.ignoresSafeArea())
            .accentColor(.red) // ini masih boleh dipakai
        }
    }
}

#Preview {
    HomeTabView()
}
