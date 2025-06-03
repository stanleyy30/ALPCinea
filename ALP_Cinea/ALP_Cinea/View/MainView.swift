import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FilmViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                filmRecommendationsView()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("\u{1F3A5} Beranda")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing:
                NavigationLink(destination: BookmarkView(viewModel: BookmarkViewModel())) {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.green)
                }
            )
            .onAppear {
                viewModel.fetchPopularFilms()
            }
        }
        .accentColor(.green)
    }

    private func filmRecommendationsView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\u{1F3AC} Rekomendasi Film")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding(.top, 24)
                .padding(.horizontal)

            if viewModel.films.isEmpty {
                ProgressView("Memuat film...")
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(viewModel.films) { film in
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
}

#Preview {
    MainView(viewModel: FilmViewModel())
}
