import SwiftUI

struct UpcomingView: View {
    @ObservedObject var viewModel: FilmViewModel
    @State private var animateGradient = false

    var body: some View {
        NavigationStack {
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
                    ZStack {
                        ForEach(0..<2, id: \.self) { index in
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.green.opacity(0.05),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 150
                                    )
                                )
                                .frame(width: 300, height: 300)
                                .offset(
                                    x: geometry.size.width * (index == 0 ? 0.2 : 0.8),
                                    y: geometry.size.height * (index == 0 ? 0.3 : 0.7)
                                )
                                .scaleEffect(animateGradient ? 1.1 : 0.9)
                                .animation(
                                    .easeInOut(duration: 4)
                                        .repeatForever(autoreverses: true)
                                        .delay(Double(index) * 1.5),
                                    value: animateGradient
                                )
                        }

                        // Main Scrollable Content
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                headerView()
                                    .frame(maxWidth: 700)
                                    .padding(.horizontal)
                                    .padding(.top, 24)

                                if viewModel.upcomingFilms.isEmpty {
                                    loadingView()
                                        .frame(maxWidth: 600)
                                        .padding(.top, 100)
                                } else {
                                    filmListView()
                                        .frame(maxWidth: 700)
                                }

                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchUpcomingFilms()
                withAnimation {
                    animateGradient = true
                }
            }
        }
        .accentColor(.green)
    }

    private func headerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.green, Color.mint],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 44, height: 44)

                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("🎞️ Film Akan Tayang")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    Text("Jangan sampai terlewat!")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.upcomingFilms.count)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.green)

                    Text("Film Baru")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green.opacity(0.2), lineWidth: 1)
                        )
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text("Coming")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.mint)

                    Text("Soon")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                )

                Spacer()
            }
        }
        .padding(.bottom, 24)
    }

    private func filmListView() -> some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.upcomingFilms) { film in
                NavigationLink(destination: FilmDetailView(film: film, viewModel: BookmarkViewModel())) {
                    FilmCardView(film: film)
                        .padding(.horizontal, 24)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.bottom, 32)
    }

    private func loadingView() -> some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color.green.opacity(0.2), lineWidth: 4)
                    .frame(width: 60, height: 60)

                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        LinearGradient(
                            colors: [Color.green, Color.mint],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(animateGradient ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 1.5)
                            .repeatForever(autoreverses: false),
                        value: animateGradient
                    )
            }

            VStack(spacing: 8) {
                Text("Memuat film akan tayang...")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Text("Sedang mengambil daftar film terbaru")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 100)
    }
}

#Preview {
    UpcomingView(viewModel: FilmViewModel())
}
