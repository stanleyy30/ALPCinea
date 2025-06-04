import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: FilmViewModel
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 8)

                    NavigationLink(destination: BookmarkView(viewModel: BookmarkViewModel())) {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top)
                .padding(.horizontal)

                // Scrollable content
                ScrollView {
                    filmRecommendationsView()
                }

                Spacer()
            }
            .sheet(isPresented: $showProfile) {
                ProfileView(viewModel: profileViewModel)
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
