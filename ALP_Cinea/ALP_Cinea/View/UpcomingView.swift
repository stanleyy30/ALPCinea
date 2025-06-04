import SwiftUI

struct UpcomingView: View {
    @ObservedObject var viewModel: FilmViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("🎞️ Film Akan Tayang")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                    .padding(.top, 24)
                    .padding(.horizontal)

                if viewModel.upcomingFilms.isEmpty {
                    ProgressView("Memuat coming soon...")
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.upcomingFilms) { film in
                                NavigationLink(destination: FilmDetailView(film: film, viewModel: BookmarkViewModel())) {
                                    FilmCardView(film: film)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.bottom, 32)
                    }
                }
                Spacer()
            }
            .onAppear {
                viewModel.fetchUpcomingFilms()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .accentColor(.green)
    }
}

#Preview {
    UpcomingView(viewModel: FilmViewModel())
}
