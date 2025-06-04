import SwiftUI

struct BookmarkView: View {
    @ObservedObject var viewModel: BookmarkViewModel

    var body: some View {
        ScrollView {
            contentView
                .padding(.top)
                .frame(maxWidth: .infinity) 
                .background(Color.black)
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
        .frame(maxWidth: .infinity, alignment: .leading)
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
            .frame(maxWidth: .infinity, alignment: .center)
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
    return NavigationView {
        BookmarkView(viewModel: viewModel)
    }
}
