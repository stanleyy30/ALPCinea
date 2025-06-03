import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @ObservedObject var viewModel: BookmarkViewModel
    @State private var showFullSynopsis = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // ...poster, info, sinopsis, ulasan...

                // ✅ Tombol Bookmark
                Button(action: {
                    viewModel.toggleBookmark(for: film)
                }) {
                    HStack {
                        Image(systemName: viewModel.isBookmarked(film) ? "bookmark.fill" : "bookmark")
                        Text(viewModel.isBookmarked(film) ? "Tersimpan" : "Tambah ke Bookmark")
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(12)
                }
                .foregroundColor(.green)
            }
            .padding()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .navigationTitle("Detail Film")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FilmDetailView(
        film: Film(
            title: "Contoh Film",
            genre: "Drama",
            rating: 8.3,
            platform: "Disney+",
            duration: "2h 15m",
            synopsis: "Ini adalah sinopsis contoh untuk film ini...",
            posterName: "/xGUOF1T3WmPsAcQEQJfnG7Ud9f8.jpg",
            reviews: [
                Review(username: "Budi", comment: "Sangat menarik dan menyentuh!"),
                Review(username: "Sari", comment: "Ceritanya luar biasa dan penuh emosi."),
                Review(username: "Andi", comment: "Film terbaik tahun ini menurut saya!")
            ]
        ),
        viewModel: BookmarkViewModel()
    )
}
