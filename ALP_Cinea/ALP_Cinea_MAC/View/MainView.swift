//
//  MainView.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FilmViewModel
    @State private var showProfile = false
    @State private var searchText = ""
    @State private var selectedGenre: String = "Semua"
    @State private var animateGradient = false

    var filteredFilms: [Film] {
        viewModel.films.filter { film in
            let matchesSearch = searchText.isEmpty || film.title.lowercased().contains(searchText.lowercased())
            let matchesGenre = selectedGenre == "Semua" || film.genres.contains(where: { $0.lowercased() == selectedGenre.lowercased() })
            return matchesSearch && matchesGenre
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.black,
                        Color(red: 0.05, green: 0.05, blue: 0.15),
                        Color.black
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                GeometryReader { geometry in
                    ForEach(0..<2, id: \.self) { index in
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color.red.opacity(0.05),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 150
                                )
                            )
                            .frame(width: 300, height: 300)
                            .offset(
                                x: geometry.size.width * (index == 0 ? 0.8 : 0.2),
                                y: geometry.size.height * (index == 0 ? 0.1 : 0.6)
                            )
                            .scaleEffect(animateGradient ? 1.1 : 0.9)
                            .animation(
                                Animation.easeInOut(duration: 4)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 1.0),
                                value: animateGradient
                            )
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    headerView()
                    
                    searchSection()
                    
                    genreFilterSection()
                    
                    ScrollView {
                        filmRecommendationsView()
                    }
                    .refreshable {
                        viewModel.fetchPopularFilms()
                    }
                }
            }
            .navigationTitle("")
            .toolbar(.hidden, for: .automatic)
            .onAppear {
                viewModel.fetchPopularFilms()
                withAnimation {
                    animateGradient = true
                }
            }
        }
        .accentColor(.red)
    }
    
    private func headerView() -> some View {
        HStack {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.red, Color.orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "film.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cinea")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("Temukan film terbaik")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            HStack(spacing: 16) {
                Button(action: {
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
                
                NavigationLink(destination: BookmarkView(viewModel: BookmarkViewModel())) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.red)
                    }
                }
                
                Button(action: {
                    showProfile.toggle()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
    
    private func searchSection() -> some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                
                TextField("Cari film, genre, atau aktor...", text: $searchText)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
    
    private func genreFilterSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Kategori")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    GenreButton(title: "Semua", selected: $selectedGenre)
                    ForEach(getAllGenres(), id: \.self) { genre in
                        GenreButton(title: genre, selected: $selectedGenre)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .padding(.bottom, 24)
    }

    private func filmRecommendationsView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("🎬 Film Pilihan")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("\(filteredFilms.count) film tersedia")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 24)

            if viewModel.films.isEmpty {
                loadingView()
            } else if filteredFilms.isEmpty {
                emptyStateView()
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(filteredFilms) { film in
                        NavigationLink(destination: FilmDetailView(film: film, viewModel: BookmarkViewModel())) {
                            FilmCardView(film: film)
                                .padding(.horizontal, 24)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }

            Spacer(minLength: 100)
        }
    }
    
    private func loadingView() -> some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(1.2)
            
            Text("Memuat film terbaru...")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
    
    private func emptyStateView() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "film.stack")
                .font(.system(size: 48, weight: .light))
                .foregroundColor(.gray.opacity(0.6))
            
            VStack(spacing: 8) {
                Text("Film tidak ditemukan")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Text("Coba ubah kata kunci atau kategori pencarian")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                searchText = ""
                selectedGenre = "Semua"
            }) {
                Text("Reset Filter")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
        .padding(.horizontal, 40)
    }

    private func getAllGenres() -> [String] {
        let allGenres = viewModel.films.flatMap { $0.genres }
        let uniqueGenres = Set(allGenres)
        return Array(uniqueGenres).sorted()
    }
}

struct GenreButton: View {
    let title: String
    @Binding var selected: String

    var isSelected: Bool {
        selected.lowercased() == title.lowercased()
    }

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selected = title
            }
        }) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            isSelected ?
                            LinearGradient(colors: [Color.red, Color.orange], startPoint: .leading, endPoint: .trailing) :
                            LinearGradient(colors: [Color.white.opacity(0.1)], startPoint: .leading, endPoint: .trailing)
                        )
                )
                .foregroundColor(isSelected ? .white : .gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(isSelected ? 0 : 0.2), lineWidth: 1)
                )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    MainView(viewModel: FilmViewModel())
}
