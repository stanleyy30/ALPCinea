import SwiftUI

struct FilmCardView: View {
    let film: Film

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(film.posterName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 140)
                .cornerRadius(12)
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 6) {
                Text(film.title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(film.genre)
                    .font(.subheadline)
                    .foregroundColor(.green)

                Text("⭐️ \(String(format: "%.1f", film.rating)) • \(film.platform)")
                    .font(.caption)
                    .foregroundColor(.gray)

                Text(film.duration)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
        .shadow(color: .green.opacity(0.25), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    FilmCardView(film: sampleFilms[0])
        .background(Color.black)
}
