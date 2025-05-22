import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🎬 Rekomendasi Film")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                        .padding(.top, 24)
                        .padding(.horizontal)

                    ForEach(sampleFilms) { film in
                        NavigationLink(destination: FilmDetailView(film: film)) {
                            FilmCardView(film: film)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 32)
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("🎥 Beranda")
            .navigationBarTitleDisplayMode(.large)
        }
        .accentColor(.green) // Navigasi & tombol
    }
}

#Preview {
    MainView()
}
