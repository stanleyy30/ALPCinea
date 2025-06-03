import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = FilmViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🎬 Rekomendasi Film")
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
                            NavigationLink(destination: FilmDetailView(film: film)) {
                                FilmCardView(film: film)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                    Spacer(minLength: 32)
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("🎥 Beranda")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.fetchPopularFilms()
            }
        }
        .accentColor(.green)
    }
}

#Preview {
    MainView()
}
