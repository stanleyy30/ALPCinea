import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FilmViewModel
    @State private var showProfile = false

    @State private var searchText = ""
    @State private var selectedGenre: String = "Semua"

    var filteredFilms: [Film] {
        viewModel.films.filter { film in
            let matchesSearch = searchText.isEmpty || film.title.lowercased().contains(searchText.lowercased())
            let matchesGenre = selectedGenre == "Semua" || film.genres.contains(where: { $0.lowercased() == selectedGenre.lowercased() })
            return matchesSearch && matchesGenre
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()

                    NavigationLink(destination: BookmarkView(viewModel: BookmarkViewModel())) {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
                .padding(.horizontal)

                TextField("Cari film...", text: $searchText)
                    .padding(10)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        GenreButton(title: "Semua", selected: $selectedGenre)
                        ForEach(getAllGenres(), id: \.self) { genre in
                            GenreButton(title: genre, selected: $selectedGenre)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 5)

                ScrollView {
                    filmRecommendationsView()
                }

                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchPopularFilms()
            }
        }
        .accentColor(.green)
    }

    private func filmRecommendationsView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🎬 Rekomendasi Film")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding(.top, 24)
                .padding(.horizontal)

            if filteredFilms.isEmpty {
                ProgressView("Memuat film...")
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(filteredFilms) { film in
                    NavigationLink(destination: FilmDetailView(film: film, viewModel: BookmarkViewModel())) {
                        FilmCardView(film: film)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }

            Spacer(minLength: 32)
        }
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
            selected = title
        }) {
            Text(title)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.green : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}


#Preview {
    MainView(viewModel: FilmViewModel())
}
