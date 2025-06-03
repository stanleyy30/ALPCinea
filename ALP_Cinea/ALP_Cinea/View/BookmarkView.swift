import SwiftUI

struct BookmarkView: View {
    let bookmarkedFilms: [Film]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("🔖 Bookmark Saya")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                    .padding(.horizontal)

                if bookmarkedFilms.isEmpty {
                    Text("Belum ada film yang dibookmark.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(bookmarkedFilms) { film in
                        NavigationLink(destination: FilmDetailView(film: film)) {
                            FilmCardView(film: film)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.top)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Bookmark")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    BookmarkView(bookmarkedFilms: sampleFilms)
}


