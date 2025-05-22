import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("🎬 Rekomendasi Film")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top)
                        .padding(.horizontal)

                    ForEach(sampleFilms) { film in
                        NavigationLink(destination: FilmDetailView(film: film)) {
                            FilmCardView(film: film)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                                .background(Color(.systemGray6).opacity(0.1))
                                .cornerRadius(12)
                                .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 20)
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("🎥 Beranda")
            .navigationBarTitleDisplayMode(.large)
            .foregroundColor(.white)
        }
        .accentColor(.green) // Untuk warna navigasi dan tombol
    }
}

#Preview {
    MainView()
}
