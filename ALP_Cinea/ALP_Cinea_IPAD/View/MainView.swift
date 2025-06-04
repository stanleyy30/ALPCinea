import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FilmViewModel
    @State private var showProfile = false

    @State private var searchText = ""
    @State private var selectedGenre: String = "Semua"

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isIpad: Bool { horizontalSizeClass == .regular }

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
                            .frame(width: isIpad ? 30 : 25, height: isIpad ? 30 : 25)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, isIpad ? 40 : 20)
                .padding(.horizontal, isIpad ? 32 : 16)

                TextField("Cari film...", text: $searchText)
                    .padding(isIpad ? 16 : 10)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .font(isIpad ? .title3 : .body)
                    .padding(.horizontal, isIpad ? 32 : 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: isIpad ? 16 : 8) {
                        GenreButton(title: "Semua", selected: $selectedGenre, isIpad: isIpad)
                        ForEach(getAllGenres(), id: \.self) { genre in
                            GenreButton(title: genre, selected: $selectedGenre, isIpad: isIpad)
                        }
                    }
                    .padding(.horizontal, isIpad ? 32 : 16)
                }
                .padding(.vertical, 8)

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
        VStack(alignment: .leading, spacing: 20) {
            Text("🎬 Rekomendasi Film")
                .font(.system(size: isIpad ? 36 : 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding(.top, isIpad ? 40 : 24)
                .padding(.horizontal, isIpad ? 32 : 16)

            if filteredFilms.isEmpty {
                ProgressView("Memuat film...")
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(filteredFilms) { film in
                    NavigationLink(destination: FilmDetailView(film: film, viewModel: BookmarkViewModel())) {
                        FilmCardView(film: film)
                            .padding(.horizontal, isIpad ? 32 : 16)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }

            Spacer(minLength: isIpad ? 64 : 32)
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
    var isIpad: Bool = false

    var isSelected: Bool {
        selected.lowercased() == title.lowercased()
    }

    var body: some View {
        Button(action: {
            selected = title
        }) {
            Text(title)
                .padding(.horizontal, isIpad ? 20 : 12)
                .padding(.vertical, isIpad ? 10 : 6)
                .background(isSelected ? Color.green : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(20)
                .font(isIpad ? .body : .footnote)
        }
    }
}

#Preview {
    MainView(viewModel: FilmViewModel())
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
}
