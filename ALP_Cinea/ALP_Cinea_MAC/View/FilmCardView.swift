//
//  FilmCardView.swift
//  ALP_Cinea_MAC
//
//  Created by student on 11/06/25.
//

import SwiftUI

struct FilmCardView: View {
    let film: Film

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            posterSection
            detailSection
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.05), Color.white.opacity(0.02)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
        .contentShape(Rectangle())
        .frame(maxWidth: 700)
    }

    private var posterSection: some View {
        ZStack {
            RemoteImageView(imageURL: film.posterName)
                .frame(width: 110, height: 160)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)

            VStack {
                HStack {
                    Spacer()
                    ratingBadge
                }
                Spacer()
                HStack {
                    platformBadge
                    Spacer()
                }
            }
            .padding(8)
        }
    }

    private var detailSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                Text(film.genres.joined(separator: " • "))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            HStack(spacing: 16) {
                ratingRow
                durationRow
                Spacer()
            }

            if !film.synopsis.isEmpty {
                Text(film.synopsis)
                    .font(.system(size: 13))
                    .foregroundColor(.gray.opacity(0.8))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            filmInfoFooter
        }
        .padding(.vertical, 4)
    }

    private var ratingBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", film.rating))
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.7))
                .background(.ultraThinMaterial)

        )
    }

    private var platformBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: "tv.fill")
                .font(.system(size: 10))
                .foregroundColor(.white)
            Text(film.platform)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    colors: [Color.red.opacity(0.8), Color.orange.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing)
                )
        )
    }

    private var ratingRow: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", film.rating))
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
        }
    }

    private var durationRow: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock.fill")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            Text(film.duration)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
        }
    }

    private var filmInfoFooter: some View {
        HStack {
            Spacer()
            HStack(spacing: 4) {
                Text("Tap untuk detail")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        ScrollView {
            VStack(spacing: 16) {
                FilmCardView(film: Film(
                    title: "The Dark Knight",
                    genres: ["Action", "Crime", "Drama"],
                    rating: 9.0,
                    platform: "Netflix",
                    duration: "2h 32m",
                    synopsis: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.",
                    posterName: "/test.jpg",
                    reviews: []
                ))

                FilmCardView(film: Film(
                    title: "Inception",
                    genres: ["Sci-Fi", "Thriller"],
                    rating: 8.8,
                    platform: "Prime Video",
                    duration: "2h 28m",
                    synopsis: "A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
                    posterName: "/test2.jpg",
                    reviews: []
                ))
            }
            .frame(maxWidth: 700)
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}
