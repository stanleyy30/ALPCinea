import SwiftUI

struct FilmCardView: View {
    let film: Film
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        HStack(alignment: .top, spacing: isIpad ? 24 : 16) {
            RemoteImageView(imageURL: film.posterName)
                .frame(width: isIpad ? 160 : 100, height: isIpad ? 224 : 140)
                .cornerRadius(10)
                .shadow(radius: 4)

            VStack(alignment: .leading, spacing: isIpad ? 12 : 8) {
                Text(film.title)
                    .font(isIpad ? .title3 : .headline)
                Text(film.genres.joined(separator: ", "))
                    .font(isIpad ? .body : .subheadline)
                    .foregroundColor(.secondary)
                Text("⭐️ \(String(format: "%.1f", film.rating)) • \(film.platform)")
                    .font(isIpad ? .callout : .caption)
                    .foregroundColor(.gray)
                Text(film.duration)
                    .font(isIpad ? .footnote : .caption2)
                    .foregroundColor(.gray)
                    .padding(.top, isIpad ? 8 : 4)
            }

            Spacer()
        }
        .padding(.horizontal, isIpad ? 32 : 16)
        .padding(.vertical, isIpad ? 16 : 8)
    }

    private var isIpad: Bool {
        horizontalSizeClass == .regular
    }
}

#Preview {
    FilmCardView(film: Film(
        title: "Contoh Film",
        genres: ["Drama"],
        rating: 7.8,
        platform: "Netflix",
        duration: "2 jam",
        synopsis: "Ini sinopsis pendek...",
        posterName: "/test.jpg",
        reviews: []
    ))
    .background(Color.black)
    .previewDevice("iPad Pro (12.9-inch) (6th generation)")  
}
