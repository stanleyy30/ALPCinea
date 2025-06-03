import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @State private var showFullSynopsis = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                RemoteImageView(imageURL: film.posterName)
                    .frame(height: 240)
                    .clipped()
                    .cornerRadius(16)
                    .shadow(color: .green.opacity(0.3), radius: 6, x: 0, y: 4)

                VStack(alignment: .leading, spacing: 10) {
                    Text(film.title)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    HStack {
                        Text(film.genre.isEmpty ? "Genre tidak diketahui" : film.genre)
                        Spacer()
                        Text("⭐️ \(String(format: "%.1f", film.rating))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.green)

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                        Text(film.duration.isEmpty ? "Durasi tidak tersedia" : film.duration)
                        Spacer()
                        Text("📺 \(film.platform)")
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }

                Divider().background(Color.gray)

                GroupBox(label: Label("Sinopsis", systemImage: "text.book.closed").foregroundColor(.green)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(film.synopsis.isEmpty ? "Sinopsis tidak tersedia." : film.synopsis)
                            .font(.body)
                            .foregroundColor(.green)
                            .lineLimit(showFullSynopsis ? nil : 4)
                            .truncationMode(.tail)

                        if !showFullSynopsis && !film.synopsis.isEmpty {
                            Button("Selengkapnya...") {
                                withAnimation {
                                    showFullSynopsis.toggle()
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 2)
                }

                GroupBox(label: Label("Ulasan Penonton", systemImage: "person.2.fill").foregroundColor(.green)) {
                    if film.reviews.isEmpty {
                        Text("Belum ada ulasan.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        VStack(spacing: 12) {
                            ForEach(film.reviews.prefix(3)) { review in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(review.username)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.green)

                                    Text("\"\(review.comment)\"")
                                        .font(.body)
                                        .italic()
                                        .foregroundColor(.green)
                                }
                                .padding()
                                .background(Color(.systemGray5).opacity(0.15))
                                .cornerRadius(12)
                            }
                        }
                    }
                }

                Spacer(minLength: 20)
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
    FilmDetailView(film: Film(
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
    ))
}
