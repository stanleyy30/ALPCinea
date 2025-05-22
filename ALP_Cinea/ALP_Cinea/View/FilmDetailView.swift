import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @State private var showFullSynopsis = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Poster
                Image(film.posterName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 5)

                // Title & Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack {
                        Text(film.genre)
                        Spacer()
                        Text("⭐️ \(String(format: "%.1f", film.rating))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.green)

                    HStack {
                        Image(systemName: "clock")
                        Text(film.duration)
                        Spacer()
                        Text("📺 \(film.platform)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }

                Divider().background(Color.white)

                // Sinopsis
                GroupBox(label: Label("Sinopsis", systemImage: "text.book.closed").foregroundColor(.green)) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(film.synopsis)
                            .font(.body)
                            .lineLimit(showFullSynopsis ? nil : 4)
                            .truncationMode(.tail)
                            .foregroundColor(.white)

                        if !showFullSynopsis {
                            Button("Selengkapnya...") {
                                withAnimation {
                                    showFullSynopsis.toggle()
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.green)
                        }
                    }
                }
                .groupBoxStyle(DefaultGroupBoxStyle())
                .foregroundColor(.white)

                // Ulasan
                GroupBox(label: Label("Ulasan Penonton", systemImage: "person.2.fill").foregroundColor(.green)) {
                    ForEach(film.reviews.prefix(3)) { review in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(review.username)
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.green)
                            Text("\"\(review.comment)\"")
                                .italic()
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(8)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Detail Film")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.white)
    }
}

#Preview {
    FilmDetailView(film: sampleFilms[0])
}
