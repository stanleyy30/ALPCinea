import SwiftUI

struct BookmarkView: View {
    @ObservedObject var viewModel: BookmarkViewModel

    var body: some View {
        ScrollView {
            contentView
                .padding(.top)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Bookmark")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView

            if viewModel.bookmarkedFilms.isEmpty {
                emptyView
            } else {
                filmListView
            }
        }
    }

    private var headerView: some View {
        Text("\u{1F4D6} Bookmark Saya")
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundColor(.green)
            .padding(.horizontal)
    }

    private var emptyView: some View {
        Text("Belum ada film yang dibookmark.")
            .foregroundColor(.gray)
            .padding()
    }

    private var filmListView: some View {
        ForEach(viewModel.bookmarkedFilms) { film in
            NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
                FilmCardView(film: film)
                    .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}


#Preview {
    let viewModel = BookmarkViewModel()
    viewModel.bookmarkedFilms = sampleFilms
    return BookmarkView(viewModel: viewModel)
}
