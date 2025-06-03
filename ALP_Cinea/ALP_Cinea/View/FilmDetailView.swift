import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @ObservedObject var viewModel: BookmarkViewModel
    @State private var showFullSynopsis = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Poster
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterName)") {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 280)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 280)
                    }
                    .padding(.horizontal)
                }

                // Judul dan info dasar
                VStack(alignment: .leading, spacing: 12) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Image(systemName: "film")
                            Text(film.genre)
                        }
                        HStack {
                            Image(systemName: "clock")
                            Text(film.duration)
                        }
                        HStack {
                            Image(systemName: "star.fill")
                            Text(String(format: "%.1f", film.rating))
                        }
                        HStack {
                            Image(systemName: "tv")
                            Text(film.platform)
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Sinopsis
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sinopsis")
                        .font(.headline)
                        .foregroundColor(.green)

                    Text(showFullSynopsis ? film.synopsis : String(film.synopsis.prefix(150)) + "...")
                        .foregroundColor(.white)
                        .font(.body)
                        .animation(.easeInOut, value: showFullSynopsis)

                    Button(action: {
                        withAnimation {
                            showFullSynopsis.toggle()
                        }
                    }) {
                        Text(showFullSynopsis ? "Tampilkan Lebih Sedikit" : "Tampilkan Selengkapnya")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)

                // Ulasan
                if !film.reviews.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ulasan")
                            .font(.headline)
                            .foregroundColor(.green)

                        ForEach(film.reviews, id: \.username) { review in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title3)
                                VStack(alignment: .leading) {
                                    Text(review.username)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(review.comment)
                                        .font(.body)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }

                // Tombol Bookmark
                Button(action: {
                    viewModel.toggleBookmark(for: film)
                }) {
                    HStack {
                        Image(systemName: viewModel.isBookmarked(film) ? "bookmark.fill" : "bookmark")
                        Text(viewModel.isBookmarked(film) ? "Tersimpan" : "Tambah ke Bookmark")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isBookmarked(film) ? Color.green.opacity(0.8) : Color.green.opacity(0.4))
                    .cornerRadius(16)
                    .shadow(radius: 5)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
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
