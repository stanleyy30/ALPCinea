import SwiftUI

struct FilmCardView: View {
    let film: Film

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(film.posterName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 140)
                .cornerRadius(10)
                .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 8) {
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
                    .padding(.top, 4)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(12)
        .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    FilmCardView(film: sampleFilms[0])
        .background(Color.black)
}
