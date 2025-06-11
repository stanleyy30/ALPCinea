//
//  FilmDetailView.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @ObservedObject var viewModel: BookmarkViewModel
    @State private var showFullSynopsis = false
    @State private var animateGradient = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterName)") {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 400)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.05))
                            .frame(height: 400)
                            .overlay(
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            )
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 700)
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text(film.title)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    VStack(alignment: .leading, spacing: 10) {
                        detailRow(icon: "film.fill", text: film.genres.joined(separator: ", "), color: .red)
                        detailRow(icon: "clock.fill", text: film.duration, color: .blue)
                        detailRow(icon: "star.fill", text: String(format: "%.1f", film.rating), color: .yellow)
                        detailRow(icon: "tv.fill", text: film.platform, color: .purple)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: 700)

                VStack(alignment: .leading, spacing: 16) {
                    Text("📖 Sinopsis")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    Text(showFullSynopsis ? film.synopsis : String(film.synopsis.prefix(200)) + "...")
                        .foregroundColor(.gray.opacity(0.9))
                        .font(.system(size: 18))
                        .lineSpacing(5)

                    Button(action: {
                        withAnimation(.spring()) {
                            showFullSynopsis.toggle()
                        }
                    }) {
                        Text(showFullSynopsis ? "Tampilkan Lebih Sedikit" : "Tampilkan Selengkapnya")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.red)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(14)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: 700)

                if !film.reviews.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("💬 Ulasan")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.white, Color.gray.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )

                        ForEach(film.reviews, id: \.username) { review in
                            HStack(alignment: .top, spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.red, Color.orange],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 40, height: 40)

                                    Image(systemName: "person.fill")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    Text(review.username)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text(review.comment)
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray.opacity(0.9))
                                }
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.03))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                                    )
                            )
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: 700)
                }

                Button(action: {
                    withAnimation(.spring()) {
                        viewModel.toggleBookmark(for: film)
                    }
                }) {
                    HStack(spacing: 14) {
                        Image(systemName: viewModel.isBookmarked(film) ? "bookmark.fill" : "bookmark")
                        Text(viewModel.isBookmarked(film) ? "Tersimpan" : "Tambah ke Bookmark")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 18)
                    .frame(maxWidth: 700)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                viewModel.isBookmarked(film) ?
                                LinearGradient(colors: [Color.green.opacity(0.8), Color.green.opacity(0.6)], startPoint: .leading, endPoint: .trailing) :
                                LinearGradient(colors: [Color.red.opacity(0.8), Color.orange.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                            )
                    )
                    .shadow(color: (viewModel.isBookmarked(film) ? Color.green : Color.red).opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 32)
            .frame(maxWidth: .infinity)
        }
        .background(
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color(red: 0.05, green: 0.05, blue: 0.15), Color.black],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                GeometryReader { geometry in
                    ForEach(0..<2, id: \.self) { index in
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [Color.red.opacity(0.04), Color.clear],
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
        )
        .navigationTitle("Detail Film")
        .onAppear {
            withAnimation {
                animateGradient = true
            }
        }
    }

    private func detailRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(color)
                .frame(width: 22)
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailView(
            film: Film(
                title: "Contoh Film",
                genres: ["Drama"],
                rating: 8.3,
                platform: "Disney+",
                duration: "2h 15m",
                synopsis: "Ini adalah sinopsis contoh yang cukup panjang untuk melihat bagaimana teks ditampilkan pada layar yang lebih besar.",
                posterName: "/xGUOF1T3WmPsAcQEQJfnG7Ud9f8.jpg",
                reviews: []
            ),
            viewModel: BookmarkViewModel()
        )
    }
}
