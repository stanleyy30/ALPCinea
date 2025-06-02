import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @State private var showFullSynopsis = false

    var body: some View {
        ScrollView {
<<<<<<< Updated upstream
            VStack(alignment: .leading, spacing: 20) {
                // Poster
                Image(film.posterName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
=======
            VStack(alignment: .leading, spacing: 24) {
                RemoteImageView(imageURL: film.posterName)
                    .frame(height: 240)
>>>>>>> Stashed changes
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 5)

                // Title & Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack {
                        Text(film.genre)
                        Spacer()
                        Text("⭐️ \(String(format: "%.1f", film.rating))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)

                    HStack {
                        Image(systemName: "clock")
                        Text(film.duration)
                        Spacer()
                        Text("📺 \(film.platform)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                Divider()

<<<<<<< Updated upstream
                // Sinopsis
                GroupBox(label: Label("Sinopsis", systemImage: "text.book.closed")) {
                    VStack(alignment: .leading, spacing: 6) {
=======
                GroupBox(label: Label("Sinopsis", systemImage: "text.book.closed").foregroundColor(.green)) {
                    VStack(alignment: .leading, spacing: 8) {
>>>>>>> Stashed changes
                        Text(film.synopsis)
                            .font(.body)
                            .lineLimit(showFullSynopsis ? nil : 4)
                            .truncationMode(.tail)

                        if !showFullSynopsis {
                            Button("Selengkapnya...") {
                                withAnimation {
                                    showFullSynopsis.toggle()
                                }
                            }
                            .font(.caption)
<<<<<<< Updated upstream
                            .foregroundColor(.blue)
=======
                            .foregroundColor(.green)
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 2)
                }

                GroupBox(label: Label("Ulasan Penonton", systemImage: "person.2.fill").foregroundColor(.green)) {
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
>>>>>>> Stashed changes
                        }
                    }
                }

                // Ulasan
                GroupBox(label: Label("Ulasan Penonton", systemImage: "person.2.fill")) {
                    ForEach(film.reviews.prefix(3)) { review in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(review.username)
                                .font(.subheadline)
                                .bold()
                            Text("\"\(review.comment)\"")
                                .italic()
                                .font(.body)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detail Film")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FilmDetailView(film: sampleFilms[0])
}
