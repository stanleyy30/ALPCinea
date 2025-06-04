import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @ObservedObject var viewModel: BookmarkViewModel
    @State private var showFullSynopsis = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var isIpad: Bool { horizontalSizeClass == .regular }

    var body: some View {
        ScrollView {
            VStack(spacing: isIpad ? 36 : 24) {

                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterName)") {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: isIpad ? 420 : 280)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: isIpad ? 420 : 280)
                    }
                    .padding(.horizontal, isIpad ? 40 : 16)
                }

                VStack(alignment: .leading, spacing: isIpad ? 18 : 12) {
                    Text(film.title)
                        .font(isIpad ? .largeTitle : .title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    VStack(alignment: .leading, spacing: isIpad ? 10 : 6) {
                        HStack {
                            Image(systemName: "film")
                            Text(film.genres.joined(separator: ", "))
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
                    .font(isIpad ? .title3 : .subheadline)
                    .foregroundColor(.gray)
                }
                .padding(.horizontal, isIpad ? 40 : 16)

                VStack(alignment: .leading, spacing: isIpad ? 14 : 8) {
                    Text("Sinopsis")
                        .font(isIpad ? .title2 : .headline)
                        .foregroundColor(.green)

                    Text(showFullSynopsis ? film.synopsis : String(film.synopsis.prefix(150)) + "...")
                        .foregroundColor(.white)
                        .font(isIpad ? .title3 : .body)
                        .animation(.easeInOut, value: showFullSynopsis)

                    Button(action: {
                        withAnimation {
                            showFullSynopsis.toggle()
                        }
                    }) {
                        Text(showFullSynopsis ? "Tampilkan Lebih Sedikit" : "Tampilkan Selengkapnya")
                            .font(isIpad ? .title3 : .subheadline)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, isIpad ? 40 : 16)

                if !film.reviews.isEmpty {
                    VStack(alignment: .leading, spacing: isIpad ? 18 : 12) {
                        Text("Ulasan")
                            .font(isIpad ? .title2 : .headline)
                            .foregroundColor(.green)

                        ForEach(film.reviews, id: \.username) { review in
                            HStack(alignment: .top, spacing: isIpad ? 16 : 10) {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(.green)
                                    .font(isIpad ? .title : .title3)
                                VStack(alignment: .leading) {
                                    Text(review.username)
                                        .font(isIpad ? .title3 : .subheadline)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(review.comment)
                                        .font(isIpad ? .title3 : .body)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, isIpad ? 40 : 16)
                }

                Button(action: {
                    viewModel.toggleBookmark(for: film)
                }) {
                    HStack {
                        Image(systemName: viewModel.isBookmarked(film) ? "bookmark.fill" : "bookmark")
                        Text(viewModel.isBookmarked(film) ? "Tersimpan" : "Tambah ke Bookmark")
                    }
                    .font(isIpad ? .title2 : .headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isBookmarked(film) ? Color.green.opacity(0.8) : Color.green.opacity(0.4))
                    .cornerRadius(16)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, isIpad ? 40 : 16)
            }
            .padding(.vertical, isIpad ? 30 : 16)
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
            genres: ["Drama"],
            rating: 8.3,
            platform: "Disney+",
            duration: "2h 15m",
            synopsis: "Ini adalah sinopsis contoh untuk film ini...",
            posterName: "/xGUOF1T3WmPsAcQEQJfnG7Ud9f8.jpg",
            reviews: []
        ),
        viewModel: BookmarkViewModel()
    )
    .previewDevice("iPad Pro (12.9-inch) (6th generation)") 
}
