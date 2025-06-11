import SwiftUI

struct BookmarkView: View {
    @ObservedObject var viewModel: BookmarkViewModel
    @State private var animateGradient = false

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView

                ScrollView {
                    contentView
                        .padding(.top)
                        .frame(maxWidth: 700)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Bookmark")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadBookmarks()
                withAnimation {
                    animateGradient = true
                }
            }
        }
    }

    private var backgroundView: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.05, green: 0.05, blue: 0.15),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            GeometryReader { geometry in
                ForEach(0..<2, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.red.opacity(0.04),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 120
                            )
                        )
                        .frame(width: 240, height: 240)
                        .offset(
                            x: geometry.size.width * (index == 0 ? 0.8 : 0.2),
                            y: geometry.size.height * (index == 0 ? 0.2 : 0.7)
                        )
                        .scaleEffect(animateGradient ? 1.1 : 0.9)
                        .animation(
                            Animation.easeInOut(duration: 4)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 1.0),
                            value: animateGradient
                        )
                }
            }
        }
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 24) {
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
        VStack(alignment: .leading, spacing: 8) {
            Text("🔖 Bookmark Saya")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.white, Color.gray.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            Text("\(viewModel.bookmarkedFilms.count) film tersimpan")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
        }
    }

    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 64, weight: .light))
                .foregroundColor(.gray.opacity(0.6))

            VStack(spacing: 8) {
                Text("Belum ada film tersimpan")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)

                Text("Film yang kamu bookmark akan muncul di sini")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 80)
        .padding(.horizontal, 40)
    }

    private var filmListView: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.bookmarkedFilms) { film in
                NavigationLink(destination: FilmDetailView(film: film, viewModel: viewModel)) {
                    FilmCardView(film: film)
                        .padding(.horizontal, 0)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    let viewModel = BookmarkViewModel()
    return BookmarkView(viewModel: viewModel)
        .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        .previewInterfaceOrientation(.landscapeLeft)
}
