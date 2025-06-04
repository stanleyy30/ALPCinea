import SwiftUI

struct BookmarkView: View {
    @ObservedObject var viewModel: BookmarkViewModel
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        ScrollView {
            contentView
                .padding(.top, isIpad ? 40 : 16)
                .frame(maxWidth: .infinity)
                .background(Color.black)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Bookmark")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadBookmarks()
        }
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: isIpad ? 24 : 16) {
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
            .font(.system(size: isIpad ? 34 : 28, weight: .bold, design: .rounded))
            .foregroundColor(.green)
            .padding(.horizontal, isIpad ? 32 : 16)
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
                    .padding(.horizontal, isIpad ? 32 : 16)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private var isIpad: Bool {
        horizontalSizeClass == .regular
    }
}

#Preview {
    let viewModel = BookmarkViewModel()
    return NavigationView {
        BookmarkView(viewModel: viewModel)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
